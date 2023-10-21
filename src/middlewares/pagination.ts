import { Request, Response, NextFunction } from 'express';
import { logger } from '../lib/logger'
import { z } from 'zod';
import { RequestWithPagination } from '../types';



const paginationSchema = z.object({
  page: z.coerce.number().int().positive().optional(),
  limit: z.coerce.number().int().positive().lte(20).optional(),
})

export function paginatedResults() {
  return (req: Request, res: Response, next: NextFunction) => {
    const { page, limit } = req.query;
    const paginationParams = paginationSchema.safeParse({ page, limit })

    const paginationClause = {
      skip: 0,
      take: 20
    }
    if (paginationParams.success) {
      const pageParsed = paginationParams.data.page ?? 1;
      const limitParsed = paginationParams.data.limit ?? 20;

      paginationClause.skip = (pageParsed - 1) * limitParsed;
      paginationClause.take = limitParsed;
    } else {
      logger.warn(`Schema validation error. ${paginationParams.error}`)
      res.status(400).json({ error: 'Invalid pagination parameters' });
    }

    (req as RequestWithPagination).paginationClause = paginationClause;

    console.log('query', req.query)
    console.log('paginationClause', paginationClause)
    next();
  }
}