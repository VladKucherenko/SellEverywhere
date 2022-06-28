import { Module } from '@nestjs/common';
import { ProductFactoryService } from './product-factory.service';
import { ProductServicesService } from './product-services.service';
import { DataServicesModule } from '../../data-services/data-services/data-services.module';

@Module({
  imports: [DataServicesModule],
  providers: [ProductFactoryService, ProductServicesService],
  exports: [ProductFactoryService, ProductServicesService],
})
export class ProductServicesModule {}
