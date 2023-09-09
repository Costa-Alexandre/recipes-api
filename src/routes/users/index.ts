import express from 'express';
import { Request, Response } from 'express';
import { prisma } from '../../index';


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


export default router;