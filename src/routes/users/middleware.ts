import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { JwtPayload } from 'jsonwebtoken';

interface RequestWithUser extends Request {
  user?: string | JwtPayload;
}

export function authenticateToken(minRole = 'ADMIN') {
  return (req: RequestWithUser, res: Response, next: NextFunction) => {
    const authHeader = req.headers.authorization;
    const token = authHeader?.split(' ')[1];

    if (!token) return res.status(401).json({ error: 'Unauthorized' });

    const jwtSecret = process.env.JWT_SECRET || '';
    try {
      const user = jwt.verify(token, jwtSecret);
      const { role: userRole } = user as JwtPayload;
      console.log(`Needs to be: ${minRole}. User is: ${userRole}`)
      switch (userRole) {
        case 'ADMIN':
          break;
        case 'EDITOR':
          if (minRole === 'USER' || minRole === 'EDITOR') break;
        case 'USER':
          if (minRole === 'USER') break;
        default:
          return res.status(401).json({ error: 'Unauthorized' });
      }

      req.user = user
      next();
    } catch (error) {
      console.log(error)
      return res.status(401).json({ error: 'Unauthorized' });
    }
  }
}