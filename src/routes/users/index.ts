import express from 'express';
import { Request, Response } from 'express';
import { RequestWithUser } from '../../types';
import { prisma } from '../../index';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import zxcvbn from 'zxcvbn';
import { authenticateToken } from './middleware';

const router = express.Router();

router.route(`/`)
  /**
   *  @openapi
   *  /countries:
   *    get:
   *      tags:
   *        - Users
   *      description: Get all users
   *      responses:
   *        200:
   *          description: Success
   */
  .get(authenticateToken, async (req: RequestWithUser, res: Response) => {
    try {
      const user = req.user;
      if (!user || typeof user === 'string') return res.status(401).json({ error: 'Unauthorized' });
      const { role } = user;
      if (role !== 'ADMIN') return res.status(401).json({ error: 'Unauthorized' });
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
      const user = await prisma.user.findUnique({ where: { email } })

      if (!user) return res.status(400).json({ error: 'Invalid credentials' })

      const isPasswordValid = await bcrypt.compare(password, user.hashedPassword);

      if (!isPasswordValid) return res.status(400).json({ error: 'Invalid credentials' })
      const jwtSecret = process.env.JWT_SECRET || '';
      const jwtToken = jwt.sign(user, jwtSecret);

      return res.status(200).json({ token: jwtToken });
    } catch (error) {
      console.log(error)
      return res.status(500).json({ error: 'Server error' })
    }
  })

router.route(`/:username`)
  .get(authenticateToken, async (req: RequestWithUser, res: Response) => {
    try {
      const loggedUser = req.user;
      if (!loggedUser || typeof loggedUser === 'string') return res.status(401).json({ error: 'Unauthorized' });
      const { username } = loggedUser;
      const { username: requestParam } = req.params;
      if (username !== requestParam) return res.status(401).json({ error: 'Unauthorized' });
      const user = await prisma.user.findUnique({ where: { username: username } })
      if (!user) throw new Error('Logged user not found');
      return res.status(200).json(user);
    } catch (error) {
      console.log(error)
      return res.status(500).json({ error: 'Server error' })
    }
  })


export default router;