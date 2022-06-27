import { Injectable } from '@nestjs/common';
import { CustomerCreateDto } from "../../../core/dtos/customer/customer-create.dto";
import { ICustomerEntity } from "../../../core/entities/customer/customer.entity";
import { CustomerBasicDto } from "../../../core/dtos/customer/customer-basic.dto";

@Injectable()
export class CustomerFactoryService {
  createNewEntity(customerCreateDto: CustomerCreateDto): ICustomerEntity {
    const customerEntity = new ICustomerEntity();
    customerEntity.customer_role_id = customerCreateDto.customerRoleId;
    customerCreateDto.username && (customerEntity.username = customerCreateDto.username);
    customerCreateDto.firstName && (customerEntity.first_name = customerCreateDto.firstName);
    customerCreateDto.lastName && (customerEntity.last_name = customerCreateDto.lastName);
    customerCreateDto.email && (customerEntity.email = customerCreateDto.email);
    customerCreateDto.phone && (customerEntity.phone = customerCreateDto.phone);

    return customerEntity;
  }

  transformToObject(customerEntity: ICustomerEntity): CustomerBasicDto {
    const customerObject = new CustomerBasicDto();
    customerObject.id = customerEntity.id;
    customerObject.customerRoleId = customerEntity.customer_role_id;
    customerObject.username = customerEntity.username;
    customerObject.lastName = customerEntity.last_name;
    customerObject.firstName = customerEntity.first_name;
    customerObject.email = customerEntity.email;
    customerObject.phone = customerEntity.phone;
    customerObject.createdAt = customerEntity.created_timestamp;
    customerObject.updatedAt = customerEntity.updated_timestamp;

    return customerObject;
  }
}
