import { JwtPayload } from 'jsonwebtoken';
import { Request } from 'express';

export interface RequestWithUser extends Request {
  user?: string | JwtPayload;
}

export interface RequestWithPagination extends Request {
  paginationClause: {
    skip: number,
    take: number
  }
}