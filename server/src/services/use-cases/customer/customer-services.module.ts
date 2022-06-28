import { Module } from '@nestjs/common';
import { CustomerFactoryService } from './customer-factory.service';
import { CustomerServicesService } from './customer-services.service';
import { DataServicesModule } from '../../data-services/data-services/data-services.module';

@Module({
  imports: [DataServicesModule],
  providers: [CustomerFactoryService, CustomerServicesService],
  exports: [CustomerFactoryService, CustomerServicesService],
})
export class CustomerServicesModule {}
