import express from 'express';
import { Request, Response } from 'express';
import { Language } from '@prisma/client';
import { mock } from 'inatic'
import { RequestWithUser } from '../../types';
import { prisma } from '../../index';
// TODO: restrict access to authenticated users
import { authenticateToken } from '../users/middleware';
import { z } from 'zod';

const languageSchema = z.object({
  id: z.coerce.number().optional(),
  code: z.string().regex(/^[a-z]{2}$/),
  language: z.string(),
  country: z.array(z.string()).optional()
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

      const result = z.array(languageSchema).safeParse(languagesWithCountry)
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
    const result = languageSchema.safeParse({ code, language })
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


export default router;