import { IProductRepository } from './repository/product-repository-services.abstract';
import { IProductEntity } from '../entities/product/product.entity';

export abstract class IDataServices {
  abstract products: IProductRepository<IProductEntity>;
}
