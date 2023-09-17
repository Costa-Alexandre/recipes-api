import { Express, Request, Response } from 'express'
// import swaggerJsdoc from 'swagger-jsdoc'
import swaggerUi from 'swagger-ui-express'
import YAML from 'yaml'
import fs from 'fs'
import path from 'path'

const yamlFilePath = path.resolve(__dirname, './recipesSchema.yml')
const swaggerDocument = YAML.parse(fs.readFileSync(yamlFilePath, 'utf8'))
function swaggerDocs(app: Express, port: number) {
  app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument))

  app.get('docs.json', (req: Request, res: Response) => {
    res.setHeader('Content-Type', 'application/json');
    res.send(swaggerDocument)
  })

  console.log('docs available at http://localhost:3000/docs')
}

export default swaggerDocs