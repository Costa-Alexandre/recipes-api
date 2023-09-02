import { Prisma, PrismaClient } from '@prisma/client';
import express from 'express';
import { Request, Response } from 'express';
import CountryRoutes from './routes/countries';


export const prisma = new PrismaClient();
const app = express();

const port = 3000;

app.use(express.json());
app.use('/countries', CountryRoutes);


const server = app.listen(port, () => {
  console.log('Server ready at: http://localhost:3000')
})