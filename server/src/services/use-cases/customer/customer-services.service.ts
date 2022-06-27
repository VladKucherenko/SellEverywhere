import { Injectable } from '@nestjs/common';

import { CustomerFactoryService } from './customer-factory.service';
import { IDataServices } from '../../../core/abstracts/data-services.abstract';
import { CustomerCreateDto } from "../../../core/dtos/customer/customer-create.dto";
import { CustomerBasicDto } from "../../../core/dtos/customer/customer-basic.dto";

@Injectable()
export class CustomerServicesService {
  constructor(
    private dataServices: IDataServices,
    private customerFactoryService: CustomerFactoryService,
  ) {}

  async createNewCustomer(
    customerInfo: CustomerCreateDto,
  ): Promise<CustomerBasicDto> {
    const customerToCreate =
      this.customerFactoryService.createNewEntity(customerInfo);

    const customerEntity = await this.dataServices.customers.create(customerToCreate);

    const customerToObject = this.customerFactoryService.transformToObject(customerEntity);

    return customerToObject;
  }
}
