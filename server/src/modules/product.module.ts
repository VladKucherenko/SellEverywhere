import { Module } from '@nestjs/common';
import { ProductServicesModule } from '../services/use-cases/product/product-services.module';
import { ProductController } from '../controllers/product/product.controller';

@Module({
  imports: [ProductServicesModule],
  controllers: [ProductController],
  providers: [],
})
export class ProductModule {}
