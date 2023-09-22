import express from 'express';
import { Request, Response } from 'express';
import { RequestWithUser } from '../types';
import type { User } from '@prisma/client';
import { prisma } from '../server';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import zxcvbn from 'zxcvbn';
import { authenticateToken } from '../routes/users/auth';

const router = express.Router();
const jwtSecret = process.env.JWT_SECRET || '';

type RefreshToken = {
  id: string;
  iat: number;
  exp: number;
}



router.route(`/`)

  .get(authenticateToken("ADMIN"), async (req: RequestWithUser, res: Response) => {
    try {
      const users = await prisma.user.findMany();
      return res.status(200).json(users);
    } catch (error) {
      console.log(error)
      return res.status(500).json({ error: 'Server error' })
    }
  })
  .post(async (req: Request, res: Response) => {
    try {
      const { email,
        username,
        password,
        countryId,
        fullName = '',
        address = '',
        city = '',
        avatar = '' } = req.body;
      const passwordCheck = zxcvbn(password);
      if (passwordCheck.score < 3) {
        const feedbackMessage = passwordCheck.feedback.warning || 'Password is too weak';
        return res.status(400).json({ error: feedbackMessage })
      }
      const hashedPassword = await bcrypt.hash(password, 10);
      const user = await prisma.user.create({
        data: {
          email,
          hashedPassword: hashedPassword,
          username,
          countryId: Number(countryId),
          fullName,
          address,
          city,
          avatar
        }
      })

      return res.status(200).json(user);
    } catch (error) {
      console.log(error)
      return res.status(500).json({ error: 'Server error' })
    }
  })

router.route(`/login`)
  .post(async (req: Request, res: Response) => {
    try {
      const { email, password } = req.body;
      const user = await prisma.user.findUnique({
        where: {
          email
        },
      })

      if (!user) return res.status(400).json({ error: 'Invalid credentials' })

      const isPasswordValid = await bcrypt.compare(password, user.hashedPassword);

      if (!isPasswordValid) return res.status(400).json({ error: 'Invalid credentials' })
      const { hashedPassword, id, ...safeUser } = user;
      const simpleUser = {
        email: user.email,
        username: user.username,
        role: user.role,
      }
      const token = jwt.sign(simpleUser, jwtSecret, { expiresIn: '1h' });
      const refreshToken = jwt.sign({ id }, jwtSecret, { expiresIn: '7d' });

      await prisma.token.create({
        data: {
          token: refreshToken,
          userId: id
        }
      })

      return res.status(200).json({ token, refreshToken, user: safeUser });
    } catch (error) {
      console.log(error)
      return res.status(500).json({ error: 'Server error' })
    }
  })

router.route(`/:username`)
  .get(authenticateToken("USER"), async (req: RequestWithUser, res: Response) => {
    try {
      const loggedUser = req.user;
      if (!loggedUser || typeof loggedUser === 'string') return res.status(401).json({ error: 'Unauthorized' });
      const { username } = loggedUser;
      const { username: requestParam } = req.params;
      if (username !== requestParam) return res.status(401).json({ error: 'Unauthorized' });
      const user = await prisma.user.findUnique({ where: { username: username } })
      if (!user) throw new Error('Logged user not found');
      const { hashedPassword, id, ...safeUser } = user;
      return res.status(200).json(safeUser);
    } catch (error) {
      console.log(error)
      return res.status(500).json({ error: 'Server error' })
    }
  })

router.route(`/token/refresh`)
  .post(async (req: Request, res: Response) => {
    try {
      const { refreshToken } = req.body;
      if (!refreshToken) return res.status(401).json({ error: 'Unauthorized' });
      const decodedRefreshToken = verifyRefreshToken(refreshToken);
      console.log(decodedRefreshToken)
      if (!decodedRefreshToken) return res.status(401).json({ error: 'Unauthorized' });
      const storedToken = await prisma.token.findUnique({
        where: {
          token: refreshToken
        },
      })
      if (!storedToken) return res.status(401).json({ error: 'Unauthorized' });

      const user = await prisma.user.findUnique({
        where: {
          id: storedToken.userId
        },
      })
      if (!user) return res.status(401).json({ error: 'Unauthorized' });
      const { hashedPassword, id, ...safeUser } = user;
      const token = jwt.sign(safeUser, jwtSecret, { expiresIn: '1h' });

      return res.status(200).json({ token });
    } catch (error) {
      console.log(error)
      return res.status(500).json({ error: 'Server error' })
    }
  })

router.route(`/token/reject`)
  .post(async (req: Request, res: Response) => {
    try {
      const { username } = req.body;
      console.log(username)
      const deletedTokens = await prisma.token.deleteMany({
        where: {
          user: {
            username
          }
        }
      })
      console.log(deletedTokens)
      return res.status(200).json({ message: 'Token rejected' });
    } catch (error) {
      console.log(error)
      return res.status(500).json({ error: 'Server error' })
    }
  })


const verifyRefreshToken = (refreshToken: string): RefreshToken | null => {
  try {
    const decodedRefreshToken = jwt.verify(refreshToken, jwtSecret);
    return decodedRefreshToken as RefreshToken;
  } catch (error) {
    return null;
  }
}

export default router;