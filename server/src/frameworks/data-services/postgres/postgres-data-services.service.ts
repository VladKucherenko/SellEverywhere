import { Injectable, OnApplicationBootstrap } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { IDataServices } from '../../../core/abstracts/data-services.abstract';
import { PostgresProductRepository } from './repository/postgres-product-repository';
import { IProductEntity } from '../../../core/entities/product/product.entity';
import { ProductEntity } from './entities/product.entity';
import { ICustomerEntity } from "../../../core/entities/customer/customer.entity";
import { PostgresCustomerRepository } from "./repository/postgres-customer-repository";
import { CustomerEntity } from "./entities/customer.entity";

@Injectable()
export class PostgresDataServices
  implements IDataServices, OnApplicationBootstrap
{
  products: PostgresProductRepository<IProductEntity>;
  customers: PostgresCustomerRepository<ICustomerEntity>;

  constructor(
    @InjectRepository(ProductEntity)
    private ProductRepository: Repository<ProductEntity>,
    @InjectRepository(CustomerEntity)
    private CustomerRepository: Repository<CustomerEntity>,
  ) {}

  onApplicationBootstrap() {
    this.products = new PostgresProductRepository<ProductEntity>(this.ProductRepository);
    this.customers = new PostgresCustomerRepository<CustomerEntity>(this.CustomerRepository);
  }
}
