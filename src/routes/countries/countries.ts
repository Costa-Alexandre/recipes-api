import express from 'express';
import { Request, Response } from 'express';
import { prisma } from '../../server';

interface CreateCountryRequest {
  id: number;
  country: string;
  code: string;
  currencyId: number;
  languages: number[];
}

interface LanguageIds {
  languages: number[];
}

const router = express.Router();

router.route(`/`)

  .get(async (req: Request, res: Response) => {
    const countries = await prisma.country.findMany()
    res.json(countries)
  })

  .post(async (req: Request<{}, {}, CreateCountryRequest>, res: Response) => {
    const { country, code, currencyId, languages = [] } = req.body

    try {

      const result = await prisma.country.create({
        data: {
          code,
          country,
          currency: { connect: { id: currencyId } },
          languages: { connect: languages.map((languageId) => ({ id: languageId })) }
        },
        select: {
          country: true,
          code: true,
          currency: { select: { currency: true } },
          languages: { select: { language: true } }
        }
      })
      res.json(result)
    } catch (error) {
      console.log(error)
      res.status(500).end()
    }
  })


router.route(`/:id`)
  .get(async (req: Request, res: Response) => {
    const { id } = req.params
    const countries = await prisma.country.findUnique({
      where: { id: Number(id) }
    })
    res.json(countries)
  })
  .put(async (req: Request, res: Response) => {
    const { id } = req.params
    const data = req.body
    const country = await prisma.country.update({
      where: {
        id: Number(id)
      },
      data: data
    })
    res.json(country)
  })
  .delete(async (req: Request, res: Response) => {
    const { id } = req.params;
    const deletedCountry = await prisma.country.delete({
      where: {
        id: Number(id)
      }
    })
    res.json(deletedCountry)
  })

router.route('/:id/languages')
  .get(async (req: Request, res: Response) => {
    const { id } = req.params
    const languages = await prisma.country.findUnique({
      where: {
        id: Number(id)
      },
      select: {
        languages: true
      }
    })
    res.json(languages)
  })
  .post(async (req: Request<{ id: number }, {}, LanguageIds>, res: Response) => {
    const { id } = req.params
    const { languages: addedLanguages } = req.body

    const removedLanguages = await prisma.country.findUnique({
      where: { id: Number(id) },
      select: { languages: true }
    })

    // Disconnect the existing languages
    await prisma.country.update({
      where: { id: Number(id) },
      data: {
        languages: {
          disconnect: removedLanguages?.languages.map(lang => ({ id: lang.id }))
        }
      }
    })

    // Connect new languages
    await prisma.country.update({
      where: { id: Number(id) },
      data: {
        languages: {
          connect: addedLanguages.map(id => ({ id: id }))
        }
      }
    })

    const updatedCountry = await prisma.country.findUnique({
      where: { id: Number(id) },
      include: {
        languages: true
      }
    })

    res.json(updatedCountry)
  })
  .put(async (req: Request<{ id: number }, {}, LanguageIds>, res: Response) => {
    const { id } = req.params
    const { languages: addedLanguages } = req.body

    const updatedCountry = await prisma.country.update({
      where: { id: Number(id) },
      data: {
        languages: {
          connect: addedLanguages.map(languageId => ({ id: languageId }))
        }
      },
      include: {
        languages: true
      }
    })
    res.json(updatedCountry)
  })
  .delete(async (req: Request<{ id: number }, {}, LanguageIds>, res: Response) => {
    const { id } = req.params
    const { languages: removedLanguages } = req.body

    const updatedCountry = await prisma.country.update({
      where: { id: Number(id) },
      data: {
        languages: {
          disconnect: removedLanguages.map(languageId => ({ id: languageId }))
        }
      },
      include: {
        languages: true
      }
    })
    res.json(updatedCountry)
  })




export default router;