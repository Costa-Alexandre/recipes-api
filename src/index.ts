import { Prisma, PrismaClient } from '@prisma/client';
import express from 'express';
import { Request, Response } from 'express';
import { CountryRoutes, UserRoutes } from './routes';
import swaggerDocs from './docs/swagger';

export const prisma = new PrismaClient();
const app = express();

const port = 3000;

app.use(express.json());
app.use('/countries', CountryRoutes);
app.use('/users', UserRoutes)

const server = app.listen(port, () => {
  console.log('Server ready at: http://localhost:3000')
  swaggerDocs(app, 3000)
})