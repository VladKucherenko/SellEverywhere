import { registerAs } from '@nestjs/config';
console.log('tetetetette', {
  clientServerHost: process.env.CLIENT_SERVER_HOST ?? 'http://localhost:3005',
  host: process.env.POSTGRES_HOST,
  port: parseInt(process.env.POSTGRES_PORT),
  username: process.env.POSTGRES_USERNAME,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DATABASE,
  checkPostgresSSL: Boolean(process.env.POSTGRES_SSL_CHECK),
})
export const appConfig = registerAs('app', async () => ({
  clientServerHost: process.env.CLIENT_SERVER_HOST ?? 'http://localhost:3005',
  host: process.env.POSTGRES_HOST,
  port: parseInt(process.env.POSTGRES_PORT),
  username: process.env.POSTGRES_USERNAME,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DATABASE,
  checkPostgresSSL: Boolean(process.env.POSTGRES_SSL_CHECK),
}));
