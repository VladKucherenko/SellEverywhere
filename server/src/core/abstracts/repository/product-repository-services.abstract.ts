import { IGenericRepository } from './generic-repository-services.abstract';

export abstract class IProductRepository<T> extends IGenericRepository<T> {
  abstract getAllProductsByDeliverer(): Promise<T[]>;
}
