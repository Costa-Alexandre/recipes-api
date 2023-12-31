import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { JwtPayload } from 'jsonwebtoken';
import { logger } from '../lib/logger'
import { RequestWithUser } from '../types';

export function authenticateToken(minRole = 'ADMIN') {
  return (req: RequestWithUser, res: Response, next: NextFunction) => {
    const authHeader = req.headers.authorization;
    const token = authHeader?.split(' ')[1];

    if (!token) {
      const message = 'Unauthorized: Authentication token missing'
      logger.warn(message)
      return res.status(401).json({ error: message });
    }

    const jwtSecret = process.env.JWT_SECRET || '';
    try {
      const user = jwt.verify(token, jwtSecret);
      const { role: userRole } = user as JwtPayload;
      switch (userRole) {
        case 'ADMIN':
          break;
        case 'EDITOR':
          if (minRole === 'USER' || minRole === 'EDITOR') break;
        case 'USER':
          if (minRole === 'USER') break;
        default:
          const message = "Forbidden: Insufficient privileges to access this resource"
          logger.warn(message)
          return res.status(403).json({ error: message });
      }

      req.user = user
      next();
    } catch (error) {
      if (error instanceof jwt.TokenExpiredError) {
        const message = 'Unauthorized: Authentication token expired'
        logger.warn(message)
        return res.status(401).json({ error: message });
      } else if (error instanceof jwt.JsonWebTokenError) {
        const message = 'Unauthorized: Invalid authentication token'
        logger.warn(message)
        return res.status(401).json({ error: message });
      } else {
        return next(error);
      }
    }
  }
}

export const loggedUserMatchesParam = (req: RequestWithUser) => {
  const { user: loggedUser } = req;
  if (!loggedUser || typeof loggedUser === 'string') return null;
  const { username } = loggedUser;
  const { username: requestParam } = req.params;
  if (username !== requestParam) return null;
  return loggedUser;
}