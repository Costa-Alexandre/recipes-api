import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { JwtPayload } from 'jsonwebtoken';
import { logger } from '../lib/logger'

interface RequestWithUser extends Request {
  user?: string | JwtPayload;
}

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
      return next(error);
    }
  }
}