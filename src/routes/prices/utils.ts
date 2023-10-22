import { Prisma } from '@prisma/client'
import { z } from 'zod'

export const paramsSchema = z.object({
  ingredient: z.string().max(36).optional(),
  market: z.string().max(36).optional(),
  unitName: z.string().max(36).optional(),
  initialDate: z.coerce.date().optional(),
  endDate: z.coerce.date().optional(),
  countryCode: z.string().regex(/^[a-z]{2}$/).optional(),
  orderBy: z.string().regex(/^(date|price):(asc|desc)$/).optional(),
}).refine(data => (data.initialDate != undefined && data.endDate != undefined) ? data.initialDate <= data.endDate : true, {
  message: 'Initial date must be less than or equal to end date',
  path: ['initialDate', 'endDate'],
})

type ParamsSchema = z.infer<typeof paramsSchema>

export const getWhereClause = (data: ParamsSchema) => {
  const { ingredient: ingredientParsed, market: marketParsed, unitName: unitNameParsed, initialDate: initialDateParsed, endDate: endDateParsed, countryCode: countryCodeParsed } = data

  const whereClause: Prisma.PriceLogWhereInput = {
    ingredient: {
      ingredient: {
        equals: ingredientParsed,
        mode: 'insensitive'
      }
    },
    marketUnit: {
      market: {
        market: {
          equals: marketParsed,
          mode: 'insensitive'
        }
      },
      unitName: {
        contains: unitNameParsed,
        mode: 'insensitive'
      },
      country: {
        code: {
          equals: countryCodeParsed,
          mode: 'insensitive'
        }
      }
    },
    date: {
      gte: initialDateParsed,
      lte: endDateParsed
    },
  }
  return whereClause;
}

export const selectClause = {
  id: true,
  date: true,
  price: true,
  marketUnit: {
    select: {
      market: {
        select: {
          market: true
        }
      },
      unitName: true,
      country: {
        select: {
          code: true
        }
      }
    }
  },
  ingredient: {
    select: {
      ingredient: true
    }
  },
} satisfies Prisma.PriceLogSelect

type Prices = Prisma.PriceLogGetPayload<{ select: typeof selectClause }>

export const getFormattedPayload = (prices: Prices[]) => prices.map((log) => ({
  id: log.id,
  date: log.date,
  ingredient: log.ingredient.ingredient,
  price: log.price,
  unitName: log.marketUnit.unitName,
  market: log.marketUnit.market.market,
  country: log.marketUnit.country.code,
}))

export const getOrderByClause = (data: ParamsSchema) => {
  const { orderBy } = data
  if (!orderBy) return undefined
  const [field, order] = orderBy.split(':')
  const orderByClause = {
    [field]: order
  }
  return orderByClause
}