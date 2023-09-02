import express from 'express';
import { Request, Response } from 'express';
import { prisma } from '../../index';

const router = express.Router();

router.get(`/`, async (req: Request, res: Response) => {
  const countries = await prisma.country.findMany()
  res.json(countries)
})

router.get(`/:id`, async (req: Request, res: Response) => {
  const { id } = req.params
  const countries = await prisma.country.findUnique({
    where: { id: Number(id) }
  })
  res.json(countries)
})

export default router;