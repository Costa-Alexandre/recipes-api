import { PrismaClient } from '@prisma/client';
import express, { ErrorRequestHandler } from 'express';
import { CountryRoutes, UserRoutes, LanguageRoutes } from './routes';
import swaggerDocs from './docs/swagger';
import { reqLogger, errorLogger, logger } from './lib/logger';
import https from 'https';


export const prisma = new PrismaClient();
const app = express();
const port = process.env.PORT || '3000';
const httpsOptions = {
  cert: process.env.SSL_CERT,
  key: process.env.SSL_KEY,
}

// Middlewares
app.use(express.json());
app.use(reqLogger);


// Routes
app.get('/health', (req, res) => {
  res.send('OK')
})
app.use('/countries', CountryRoutes);
app.use('/users', UserRoutes)
app.use('/languages', LanguageRoutes)

app.use(errorLogger);

const errorHandler: ErrorRequestHandler = (err, req, res, next) => {
  res.status(500).send({ error: 'Something went wrong' })
}
app.use(errorHandler)

const server = app.listen(port, () => {
  logger.info(`Server ready at: http://localhost:${port}`)
  swaggerDocs(app, port)
})
