import express, { NextFunction, Request, Response } from 'express'

import * as yup from 'yup'
import { json } from 'body-parser'
import { sequelize } from './services/sequelize'
import { ContactRepository } from './repositories/contact-repository'

const port = process.env.PORT

const configureSequelize = async () => {
  await sequelize
    .authenticate()
    .then(() => console.log('Database auth ok'))
    .catch(console.log)

  await sequelize
    .sync({ alter: true, force: false, logging: false })
    .then(() => console.log('Database sync ok'))
    .catch(console.log)
}

const main = async () => {
  await configureSequelize()

  const app = express()

  const repository = new ContactRepository()

  app.use(json())

  app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    console.error(err)

    res.status(400).json({})
  })

  app.use((req, res, next) => {
    const now = new Date()

    res.contentType('json')
    res.setHeader('Access-Control-Allow-Origin', '*')

    console.info(`${now.toISOString()} ${req.method} ${req.url}`)
    console.info(req.body)

    next()
  })

  app.get('/api/contact', async (req, res, next) => {
    try {
      const contacts = await repository.list()

      res.status(200).json(contacts)
    } catch (error) {
      next(error)
    }
  })

  const createSchema = yup.object({
    address: yup.string().required(),
    name: yup.string().required(),
    phoneNumber: yup.string().required(),
  })

  app.post('/api/contact', async (req, res, next) => {
    try {
      const { address, name, phoneNumber } = await createSchema.validate(
        req.body
      )

      await repository.create({ address, name, phoneNumber })

      res.status(201).json({})
    } catch (error) {
      next(error)
    }
  })

  app.patch('/api/contact/:id', async (req, res, next) => {
    try {
      const id = await yup.string().required().validate(req.params.id)

      const { address, name, phoneNumber } = await createSchema.validate(
        req.body
      )

      await repository.update({ address, name, phoneNumber, id })

      res.status(200).json({})
    } catch (error) {
      next(error)
    }
  })

  app.delete('/api/contact/:id', async (req, res, next) => {
    try {
      const id = await yup.string().required().validate(req.params.id)

      await repository.delete({ id })

      res.status(200).json({})
    } catch (error) {
      next(error)
    }
  })

  app.listen(port, () => {
    console.log(`listening on port ${port}`)
  })
}

main()
