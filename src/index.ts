import { Prisma, PrismaClient } from '@prisma/client';
import express from 'express';
import { Request, Response } from 'express';


const prisma = new PrismaClient();
const app = express();
const port = 3000;

app.use(express.json());

app.get(`/countries/`, async (req: Request, res: Response) => {
  const countries = await prisma.countries.findMany()
  res.json(countries)
})

app.get(`/countries/:id`, async (req: Request, res: Response) => {
  const { id } = req.params
  const countries = await prisma.countries.findUnique({
    where: { id: Number(id) }
  })
  res.json(countries)
})

const server = app.listen(port, () => {
  console.log('Server ready at: http://localhost:3000')
})