import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { PostgresDataServices } from './postgres-data-services.service';
import { ProductEntity } from './entities/product.entity';
import { IDataServices } from '../../../core/abstracts/data-services.abstract';
import { ormConfig } from '../../../../configs';
import { CustomerEntity } from "./entities/customer.entity";

@Module({
  imports: [
    TypeOrmModule.forFeature([ProductEntity, CustomerEntity]),
    TypeOrmModule.forRoot(ormConfig),
  ],
  providers: [
    {
      provide: IDataServices,
      useClass: PostgresDataServices,
    },
  ],
  exports: [IDataServices],
})
export class PostgresDataServicesModule {}
