import { DataTypes, Sequelize } from 'sequelize'
import { ContactInstance } from '../typescript/contact'

export const sequelize = new Sequelize(process.env.CONNECTION_URL, {
  ssl: true,
  username: process.env.CONNECTION_USERNAME,
  password: process.env.CONNECTION_PASSWORD,
  dialect: 'mysql',
})

const baseAttributes = {
  id: {
    primaryKey: true,
    type: DataTypes.STRING,
  },
  createdAt: {
    type: DataTypes.DATE,
  },
  updatedAt: {
    type: DataTypes.DATE,
  },
}

export const ContactModel = sequelize.define<ContactInstance>(
  process.env.CONTACT_TABLE_NAME,
  {
    ...baseAttributes,
    address: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    phoneNumber: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  },
  {
    freezeTableName: true,
  }
)
