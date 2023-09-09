import { JwtPayload } from 'jsonwebtoken';
import { Request } from 'express';

export interface RequestWithUser extends Request {
  user?: string | JwtPayload;
}