import express from 'express';
import { Request, Response } from 'express';
import { Language } from '@prisma/client';
import { mock } from 'inatic'
import { RequestWithUser } from '../../types';
import { prisma } from '../../index';
// TODO: restrict access to authenticated users
import { authenticateToken } from '../users/middleware';
import { z } from 'zod';

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

const status500error = { error: 'Internal server error' }

const router = express.Router();

router.route(`/`)
  .get(authenticateToken("EDITOR"), async (req: RequestWithUser, res: Response) => {
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
      console.log(error)
      res.status(500).json(status500error)
    }
  })
  .post(authenticateToken("EDITOR"), async (req: RequestWithUser, res: Response) => {
    const { code, language } = req.body;
    const result = languagePOSTSchema.safeParse({ code, language })
    if (!result.success) {
      return res.status(400).json({ error: result.error })
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
      console.log(error)
      res.status(500).json(status500error)
    }
  })


router.route(`/:id`)
  .put(authenticateToken("EDITOR"), async (req: RequestWithUser, res: Response) => {
    const { body: { code, language }, params: { id } } = req;
    const validationResult = languagePUTSchema.safeParse({ id, code, language })
    if (!validationResult.success) {
      return res.status(400).json({ error: 'Validation error', details: validationResult.error })
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
      console.log(error)
      res.status(500).json(status500error)
    }
  })
  .delete(authenticateToken("EDITOR"), async (req: RequestWithUser, res: Response) => {
    const { id } = req.params;
    const validationResult = languageDELETESchema.safeParse({ id })
    if (!validationResult.success) {
      return res.status(400).json({ error: 'Validation error', details: validationResult.error })
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
      console.log(error)
      res.status(500).json(status500error)
    }
  })


export default router;