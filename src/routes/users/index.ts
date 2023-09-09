import express from 'express';
import { Request, Response } from 'express';
import { prisma } from '../../index';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';


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
  .get(async (req: Request, res: Response) => {
    const users = await prisma.user.findMany()
    res.json(users)
  })
  .post(async (req: Request, res: Response) => {
    const { email, password } = req.body;
    try {
      const salt = await bcrypt.genSalt();
      const hashedPassword = await bcrypt.hash(password, salt);
      console.log(salt, hashedPassword);
    } catch (error) {
      console.log(error);
    }
    return res.status(200).json({ message: 'User created' })
  })

router.route(`/login`)
  .post(async (req: Request, res: Response) => {

  })


export default router;