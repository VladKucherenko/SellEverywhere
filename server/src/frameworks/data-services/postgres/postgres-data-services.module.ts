import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { PostgresDataServices } from './postgres-data-services.service';
import { ProductEntity } from './entities/product.entity';
import { IDataServices } from '../../../core/abstracts/data-services.abstract';
import { ormConfig } from '../../../../configs';
console.log('config', ormConfig)
@Module({
  imports: [
    TypeOrmModule.forFeature([ProductEntity]),
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
