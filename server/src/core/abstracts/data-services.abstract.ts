import { IProductRepository } from './repository/product-repository-services.abstract';
import { IProductEntity } from '../entities/product/product.entity';
import { ICustomerRepository } from "./repository/customer-repository-services.abstract";
import { ICustomerEntity } from "../entities/customer/customer.entity";

export abstract class IDataServices {
  abstract products: IProductRepository<IProductEntity>;
  abstract customers: ICustomerRepository<ICustomerEntity>;
}
