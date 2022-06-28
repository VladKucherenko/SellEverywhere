import {
  Body,
  Controller,
  Post,
  UsePipes,
  ValidationPipe,
} from '@nestjs/common';
import { CustomerCreateDto } from "../../core/dtos/customer/customer-create.dto";
import {CustomerServicesService} from "../../services/use-cases/customer/customer-services.service";

@Controller('customer')
export class CustomerController {
  constructor(private readonly customerServices: CustomerServicesService) {}

  // TODO: make a normal response handler
  @Post()
  @UsePipes(new ValidationPipe())
  createNewProduct(@Body() customerInfo: CustomerCreateDto) {
    return this.customerServices.createNewCustomer(customerInfo);
  }
}
