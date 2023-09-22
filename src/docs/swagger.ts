import { Express, Request, Response } from 'express'
import swaggerUi from 'swagger-ui-express'
import YAML from 'yaml'
import fs from 'fs'
import path from 'path'
import { logger } from '../lib/logger'

const yamlFilePath = path.resolve(__dirname, './recipesSchema.yml')
const swaggerDocument = YAML.parse(fs.readFileSync(yamlFilePath, 'utf8'))
function swaggerDocs(app: Express, port: string) {
  app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument))

  app.get('docs.json', (req: Request, res: Response) => {
    res.setHeader('Content-Type', 'application/json');
    res.send(swaggerDocument)
  })

  logger.info(`Docs available at: http://localhost:${port}/docs`)
}

export default swaggerDocs