import express from 'express';
import { Prisma } from '@prisma/client';
import { Response, NextFunction } from 'express';
import { RequestWithUser } from '../../types';
import { prisma } from '../../server';
import { authenticateToken } from '../../auth/auth';
import { z } from 'zod';
import { logger } from '../../lib/logger'

const languageRequiredSchema = {
  code: z.string().regex(/^[a-z]{2}$/),
  language: z.string(),
}
const languageGETSchema = z.object({
  id: z.coerce.number().optional(),
  ...languageRequiredSchema,
  country: z.array(z.string()).optional()
})

const languagePOSTSchema = z.object({
  ...languageRequiredSchema
})

const languagePUTSchema = z.object({
  id: z.coerce.number(),
  code: z.string().regex(/^[a-z]{2}$/).optional(),
  language: z.string().optional(),
})

const languageDELETESchema = z.object({
  id: z.coerce.number(),
})

const router = express.Router();

router.route(`/`)
  .get(authenticateToken("EDITOR"), async (req: RequestWithUser, res: Response, next: NextFunction) => {
    try {
      const languages = await prisma.language.findMany({
        include: {
          country: {
            select: {
              country: true
            }
          }
        }
      })

      const languagesWithCountry = languages.map((language) => {
        return {
          ...language,
          country: language.country.map((country) => country.country)
        }
      })

      const result = z.array(languageGETSchema).safeParse(languagesWithCountry)
      if (!result.success) {
        throw new Error(`Schema validation failed.`)
      }

      return res.status(200).json(languagesWithCountry)
    } catch (error) {
      next(error)
    }
  })
  .post(authenticateToken("EDITOR"), async (req: RequestWithUser, res: Response, next: NextFunction) => {
    const { code, language } = req.body;
    const validationResult = languagePOSTSchema.safeParse({ code, language })
    if (!validationResult.success) {
      logger.warn(`Schema validation error. ${validationResult.error}`)
      return res.status(400).json({ error: `Schema validation error.` })
    }

    try {
      const newLanguage = await prisma.language.create({
        data: {
          code,
          language
        }
      })

      res.status(200).json(newLanguage)

    } catch (error) {
      if (error instanceof Prisma.PrismaClientKnownRequestError) {
        if (error.code === 'P2002') {
          return res.status(400).json({ error: `There is a unique constraint violation, a new language cannot be created` })
        }
      }
      next(error)
    }
  })

router.route(`/:id`)
  .put(authenticateToken("EDITOR"), async (req: RequestWithUser, res: Response, next: NextFunction) => {
    const { body: { code, language }, params: { id } } = req;
    console.log('id', id, typeof id)
    const validationResult = languagePUTSchema.safeParse({ id, code, language })
    if (!validationResult.success) {
      logger.warn(`Schema validation error. ${validationResult.error}`)
      return res.status(400).json({ error: `Schema validation error.` })
    }

    const { data: { id: idParsed, code: codeParsed, language: languageParsed } } = validationResult

    try {
      const updatedLanguage = await prisma.language.update({
        where: {
          id: idParsed
        },
        data: {
          code: codeParsed,
          language: languageParsed
        }
      })

      res.status(200).json(updatedLanguage)

    } catch (error) {
      if (error instanceof Prisma.PrismaClientKnownRequestError) {
        logger.warn(error.message)
        if (error.code === 'P2002') {
          return res.status(400).json({ error: `There is a unique constraint violation, this language cannot be updated` })
        }
        if (error.code === 'P2025') {
          return res.status(404).json({ error: `The language with id [${idParsed}] was not found` })
        }
      }
      next(error)
    }
  })
  .delete(authenticateToken("EDITOR"), async (req: RequestWithUser, res: Response, next: NextFunction) => {
    const { id } = req.params;
    const validationResult = languageDELETESchema.safeParse({ id })
    if (!validationResult.success) {
      logger.warn(`Schema validation error. ${validationResult.error}`)
      return res.status(400).json({ error: 'Schema validation error' })
    }

    const { data: { id: idParsed } } = validationResult

    try {
      const deletedLanguage = await prisma.language.delete({
        where: {
          id: idParsed
        }
      })

      res.status(200).json(deletedLanguage)

    } catch (error) {
      if (error instanceof Prisma.PrismaClientKnownRequestError) {
        logger.warn(error.message)
        if (error.code === 'P2025') {
          return res.status(404).json({ error: `The language with id [${idParsed}] was not found` })
        }
      }
      next(error)
    }
  })
  .get(authenticateToken("USER"), async (req: RequestWithUser, res: Response, next: NextFunction) => {
    const { id } = req.params;
    const validationResult = languageDELETESchema.safeParse({ id })
    if (!validationResult.success) {
      logger.warn(`Schema validation error. ${validationResult.error}`)
      return res.status(400).json({ error: 'Schema validation error' })
    }

    const { data: { id: idParsed } } = validationResult

    try {
      const language = await prisma.language.findUniqueOrThrow({
        where: {
          id: idParsed
        },
        include: {
          country: {
            select: {
              country: true
            }
          }
        }
      })

      const languagesWithCountry = {
        ...language,
        country: language?.country.map((country) => country.country)
      }

      const validationResult = languageGETSchema.safeParse(languagesWithCountry)

      if (!validationResult.success) {
        logger.warn(`Schema validation error. ${validationResult.error}`)
        throw new Error(`Schema validation failed.`)
      }

      return res.status(200).json(validationResult.data)
    } catch (error) {
      if (error instanceof Prisma.PrismaClientKnownRequestError) {
        logger.warn(error.message)
        if (error.code === 'P2025') {
          return res.status(404).json({ error: `The language with id [${idParsed}] was not found` })
        }
      }
      next(error)
    }
  })


export default router;