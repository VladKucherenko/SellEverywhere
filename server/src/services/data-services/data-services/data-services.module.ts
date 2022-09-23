import { Module } from '@nestjs/common';
import { PostgresDataServicesModule } from '../../../frameworks/data-services/postgres/postgres-data-services.module';

@Module({
  imports: [PostgresDataServicesModule],
  providers: [],
  exports: [PostgresDataServicesModule],
})
export class DataServicesModule {}
