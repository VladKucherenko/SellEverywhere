import { TypeOrmModuleOptions } from '@nestjs/typeorm';
require('dotenv').config({
  path: `${process.cwd()}/.env.${process.env.NODE_ENV}`,
});

const sslCheck = {
  ssl: {
    rejectUnauthorized: false,
  },
};

export const ormConfig: TypeOrmModuleOptions = {
  type: 'postgres',
  host: process.env.POSTGRES_HOST,
  port: parseInt(process.env.POSTGRES_PORT),
  username: process.env.POSTGRES_USERNAME,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DATABASE,
  entities: ['dist/**/*.entity{.ts,.js}'],
  synchronize: false,
  autoLoadEntities: true,
  ...(process.env.POSTGRES_SSL_CHECK === 'true' && sslCheck),
};
