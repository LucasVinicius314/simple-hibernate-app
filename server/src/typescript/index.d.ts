declare global {
  namespace NodeJS {
    interface ProcessEnv {
      CONNECTION_URL: string
      CONNECTION_USERNAME: string
      CONNECTION_PASSWORD: string
      CONTACT_TABLE_NAME: string
      PORT: string
    }
  }
}

export {}
