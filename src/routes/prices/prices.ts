import express from 'express';
import { Request, Response } from 'express';
import { RequestWithUser } from '../../types';
import { prisma } from '../../server';
import { authenticateToken } from '../../auth/auth';
import { z } from 'zod';
import { logger } from '../../lib/logger'
import { Prisma } from '@prisma/client';

const paramsSchema = z.object({
  ingredient: z.string().max(36).optional(),
  market: z.string().max(36).optional(),
  unitName: z.string().max(36).optional(),
  initialDate: z.coerce.date().optional(),
  endDate: z.coerce.date().optional(),
  countryCode: z.string().regex(/^[a-z]{2}$/).optional()
})


const router = express.Router();

router.route(`/`)

  .get(authenticateToken("ADMIN"), async (req: RequestWithUser, res: Response) => {
    const { ingredient, market, unitName, initialDate, endDate, countryCode } = req.query;
    const validationResult = paramsSchema.safeParse({ ingredient, market, unitName, initialDate, endDate, countryCode })
    if (!validationResult.success) {
      logger.warn(`Schema validation error. ${validationResult.error}`)
      return res.status(400).json({ error: `Schema validation error.` })
    }

    const { data: { ingredient: ingredientParsed, market: marketParsed, unitName: unitNameParsed, initialDate: initialDateParsed, endDate: endDateParsed, countryCode: countryCodeParsed } } = validationResult

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

    const selectClause = {
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

    const prices = await prisma.priceLog.findMany({
      where: whereClause,
      select: selectClause
    })

    const flatPrices = prices.map((log) => {
      return {
        id: log.id,
        date: log.date,
        ingredient: log.ingredient.ingredient,
        price: log.price,
        unitName: log.marketUnit.unitName,
        market: log.marketUnit.market.market,
        country: log.marketUnit.country.code,
      }
    })

    const resultLength = flatPrices.length;
    const queryParams = Object.fromEntries(Object.entries(validationResult.data).filter(([key, value]) => value !== undefined));

    res.json({ resultLength, queryParams, flatPrices });
  })



export default router;