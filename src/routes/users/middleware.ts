import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { JwtPayload } from 'jsonwebtoken';

interface RequestWithUser extends Request {
  user?: string | JwtPayload;
}

export function authenticateToken(req: RequestWithUser, res: Response, next: NextFunction) {
  const authHeader = req.headers.authorization;
  const token = authHeader?.split(' ')[1];

  if (!token) return res.status(401).json({ error: 'Unauthorized' });

  const jwtSecret = process.env.JWT_SECRET || '';
  try {
    const user = jwt.verify(token, jwtSecret);
    req.user = user
    next();
  } catch (error) {
    console.log(error)
    return res.status(401).json({ error: 'Unauthorized' });
  }
}