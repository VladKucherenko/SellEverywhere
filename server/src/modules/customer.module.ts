import { Module } from '@nestjs/common';
import { CustomerController } from "../controllers/customer/customer.controller";
import { CustomerServicesModule } from "../services/use-cases/customer/customer-services.module";

@Module({
  imports: [CustomerServicesModule],
  controllers: [CustomerController],
  providers: [],
})
export class CustomerModule {}
