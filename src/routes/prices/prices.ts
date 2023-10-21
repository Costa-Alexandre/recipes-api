import express from 'express';
import { Request, Response, NextFunction } from 'express';
import { RequestWithPagination, RequestWithUser } from '../../types';
import { prisma } from '../../server';
import { authenticateToken, loggedUserMatchesParam } from '../../auth/auth';
import { z } from 'zod';
import { logger } from '../../lib/logger'
import { Prisma } from '@prisma/client';
import { paginatedResults } from '../../middlewares/pagination';

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

  .get(authenticateToken('ADMIN'), paginatedResults(), async (req: Request, res: Response, next: NextFunction) => {
    const { paginationClause } = req as RequestWithPagination;
    const { ingredient, market, unitName, initialDate, endDate, countryCode, page, limit } = req.query;
    const validationResult = paramsSchema.safeParse({ ingredient, market, unitName, initialDate, endDate, countryCode })

    if (!validationResult.success) {
      logger.warn(`Schema validation error. ${validationResult.error}`)
      return res.status(400).json({ error: `Schema validation error.` })
    }

    const { data } = validationResult
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

    try {

      const [prices, countPrices] = await prisma.$transaction([prisma.priceLog.findMany({
        where: whereClause,
        select: selectClause,
        skip: paginationClause.skip,
        take: paginationClause.take,
      }), prisma.priceLog.count({ where: whereClause })])

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

      const resultsLength = flatPrices.length;
      const queryParams = Object.fromEntries(Object.entries(data).filter(([key, value]) => value !== undefined));
      const results = {
        resultsLength: resultsLength,
        totalResults: countPrices,
        queryParams,
        paginationParams: {
          page: Math.ceil((paginationClause.skip / paginationClause.take) + 1),
          lastPage: Math.ceil(countPrices / paginationClause.take),
          limit: paginationClause.take
        },
        flatPrices
      }
      res.status(200).json(results);
    } catch (error) {
      next(error)
    }
  })

router.route(`/:username`)
  .get(authenticateToken('USER'), paginatedResults(), async (req: Request, res: Response, next: NextFunction) => {

    const loggedUser = loggedUserMatchesParam(req);
    if (!loggedUser) return res.status(401).json({ error: 'Unauthorized' });

    const { paginationClause } = req as RequestWithPagination;
    const { ingredient, market, unitName, initialDate, endDate, countryCode } = req.query;
    const validationResult = paramsSchema.safeParse({ ingredient, market, unitName, initialDate, endDate, countryCode })

    if (!validationResult.success) {
      logger.warn(`Schema validation error. ${validationResult.error}`)
      return res.status(400).json({ error: `Schema validation error.` })
    }

    const { data } = validationResult
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
      User: {
        username: loggedUser.username
      }
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

    try {

      const [prices, countPrices] = await prisma.$transaction([prisma.priceLog.findMany({
        where: whereClause,
        select: selectClause,
        skip: paginationClause.skip,
        take: paginationClause.take,
      }), prisma.priceLog.count({ where: whereClause })])

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

      const resultsLength = flatPrices.length;
      const queryParams = Object.fromEntries(Object.entries(data).filter(([key, value]) => value !== undefined));
      const results = {
        resultsLength: resultsLength,
        totalResults: countPrices,
        queryParams,
        paginationParams: {
          page: Math.ceil((paginationClause.skip / paginationClause.take) + 1),
          lastPage: Math.ceil(countPrices / paginationClause.take),
          limit: paginationClause.take
        },
        flatPrices
      }
      res.status(200).json(results);
    } catch (error) {
      next(error)
    }
  })

export default router;