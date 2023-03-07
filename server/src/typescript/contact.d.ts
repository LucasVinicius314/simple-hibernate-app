import { Model, Optional } from 'sequelize'
import { SequelizeBaseFieldKeys, SequelizeBaseFields } from './sequelize'

export type ContactAttributes = {
  address: string
  name: string
  phoneNumber: string
} & SequelizeBaseFields

export type ContactCreationAttributes = Optional<
  ContactAttributes,
  SequelizeBaseFieldKeys
>

export type ContactInstance = Model<
  ContactAttributes,
  ContactCreationAttributes
> &
  ContactAttributes
