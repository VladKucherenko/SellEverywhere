import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { DataServicesModule } from '../services/data-services/data-services/data-services.module';
import { AppModule } from './app.module';
import { appConfig } from '../../configs';
import { ProductModule } from './product.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: `${process.cwd()}/.env.${process.env.NODE_ENV}`,
      isGlobal: true,
      load: [appConfig],
    }),
    DataServicesModule,
    ProductModule,
    AppModule,
  ],
  controllers: [],
  providers: [],
})
export class MainModule {}
