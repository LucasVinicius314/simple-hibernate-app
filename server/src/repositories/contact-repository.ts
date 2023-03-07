import { randomUUID } from 'crypto'
import { ContactModel } from '../services/sequelize'
import { ContactInstance } from '../typescript/contact'

export class ContactRepository {
  create: (params: {
    address: string
    name: string
    phoneNumber: string
  }) => Promise<ContactInstance> = async ({ address, name, phoneNumber }) => {
    return await ContactModel.create({
      address,
      name,
      phoneNumber,
      id: randomUUID(),
    })
  }

  list: () => Promise<ContactInstance[]> = async () => {
    return await ContactModel.findAll()
  }

  update: (params: {
    id: string
    address: string
    name: string
    phoneNumber: string
  }) => Promise<void> = async ({ address, name, phoneNumber, id }) => {
    await ContactModel.update(
      {
        address,
        name,
        phoneNumber,
      },
      { where: { id } }
    )
  }

  delete: (params: { id: string }) => Promise<void> = async ({ id }) => {
    await ContactModel.destroy({ where: { id } })
  }
}
