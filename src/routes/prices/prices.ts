import express from 'express';
import { Request, Response, NextFunction } from 'express';
import { RequestWithPagination } from '../../types';
import { prisma } from '../../server';
import { authenticateToken, loggedUserMatchesParam } from '../../auth/auth';
import { logger } from '../../lib/logger'
import { paginatedResults } from '../../middlewares/pagination';
import { paramsSchema, getWhereClause, getFormattedPayload, selectClause as getSelectClause, getOrderByClause } from './utils';

const router = express.Router();

router.route(`/`)

  .get(authenticateToken('ADMIN'), paginatedResults(), async (req: Request, res: Response, next: NextFunction) => {
    const { paginationClause } = req as RequestWithPagination;
    const { ingredient, market, unitName, initialDate, endDate, countryCode, orderBy } = req.query;
    const validationResult = paramsSchema.safeParse({ ingredient, market, unitName, initialDate, endDate, countryCode, orderBy })

    if (!validationResult.success) {
      logger.warn(`Schema validation error. ${validationResult.error}`)
      return res.status(400).json({ error: `Schema validation error.` })
    }

    const { data } = validationResult
    const whereClause = getWhereClause(data)
    const selectClause = getSelectClause
    const orderByClause = getOrderByClause(data)

    try {
      const [prices, countPrices] = await prisma.$transaction([prisma.priceLog.findMany({
        where: whereClause,
        select: selectClause,
        skip: paginationClause.skip,
        take: paginationClause.take,
        orderBy: orderByClause
      }), prisma.priceLog.count({ where: whereClause })])

      const formattedPriceLogs = getFormattedPayload(prices)

      const queryResults = formattedPriceLogs.length;
      const queryParams = Object.fromEntries(Object.entries(data).filter(([key, value]) => value !== undefined));
      const results = {
        queryResults: queryResults,
        totalResults: countPrices,
        queryParams,
        paginationParams: {
          page: Math.ceil((paginationClause.skip / paginationClause.take) + 1),
          lastPage: Math.ceil(countPrices / paginationClause.take),
          limit: paginationClause.take
        },
        priceLogs: formattedPriceLogs
      }
      res.status(200).json(results);
    } catch (error) {
      next(error)
    }
  })

router.route(`/user/:username`)
  .get(authenticateToken('USER'), paginatedResults(), async (req: Request, res: Response, next: NextFunction) => {

    const loggedUser = loggedUserMatchesParam(req);
    if (!loggedUser) return res.status(403).json({ error: 'Forbidden: Insufficient privileges to access this resource' });

    const { paginationClause } = req as RequestWithPagination;
    const { ingredient, market, unitName, initialDate, endDate, countryCode, orderBy } = req.query;
    const validationResult = paramsSchema.safeParse({ ingredient, market, unitName, initialDate, endDate, countryCode, orderBy })

    if (!validationResult.success) {
      logger.warn(`Schema validation error. ${validationResult.error}`)
      return res.status(400).json({ error: `Schema validation error.` })
    }

    const { data } = validationResult

    const whereClause = getWhereClause(data)
    whereClause.User = {
      username: loggedUser.username
    }

    const selectClause = getSelectClause
    const orderByClause = getOrderByClause(data)

    try {
      const [prices, countPrices] = await prisma.$transaction([prisma.priceLog.findMany({
        where: whereClause,
        select: selectClause,
        skip: paginationClause.skip,
        take: paginationClause.take,
        orderBy: orderByClause
      }), prisma.priceLog.count({ where: whereClause })])

      const formattedPriceLogs = getFormattedPayload(prices)

      const queryResults = formattedPriceLogs.length;
      const queryParams = Object.fromEntries(Object.entries(data).filter(([key, value]) => value !== undefined));
      const results = {
        queryResults: queryResults,
        totalResults: countPrices,
        queryParams,
        paginationParams: {
          page: Math.ceil((paginationClause.skip / paginationClause.take) + 1),
          lastPage: Math.ceil(countPrices / paginationClause.take),
          limit: paginationClause.take
        },
        priceLogs: formattedPriceLogs
      }
      res.status(200).json(results);
    } catch (error) {
      next(error)
    }
  })

router.route(`/ingredient/:ingredient`)
  .get(authenticateToken('USER'), async (req: Request, res: Response, next: NextFunction) => {

    const { market, unitName, initialDate, endDate, countryCode } = req.query;
    const { ingredient } = req.params;
    const validationResult = paramsSchema.safeParse({ ingredient, market, unitName, initialDate, endDate, countryCode })

    if (!validationResult.success) {
      logger.warn(`Schema validation error. ${validationResult.error}`)
      return res.status(400).json({ error: `Schema validation error.` })
    }

    const { data } = validationResult

    const whereClause = getWhereClause(data)

    try {
      const prices = await prisma.priceLog.aggregate({
        where: whereClause,
        _count: {
          id: true,
        },
        _avg: {
          price: true
        },
        _min: {
          price: true
        },
        _max: {
          price: true
        },
      })

      console.log('COUNT', prices._count.id)
      if (prices._count.id === 0) return res.status(404).json({ error: `Not found` })

      const queryParams = Object.fromEntries(Object.entries(data).filter(([key, value]) => value !== undefined));
      const results = {
        totalResults: prices._count.id,
        queryParams,
        averagePrice: prices._avg.price?.toFixed(2),
        minPrice: prices._min.price,
        maxPrice: prices._max.price,
      }
      res.status(200).json(results);
    } catch (error) {
      next(error)
    }
  })

export default router;


