import { Repository } from 'typeorm';
import { IProductRepository } from '../../../../core/abstracts/repository/product-repository-services.abstract';
import { PostgresGenericRepository } from './postgres-generic-repository';

export class PostgresProductRepository<T>
  extends PostgresGenericRepository<T>
  implements IProductRepository<T>
{
  repository: Repository<T>;

  constructor(repository: Repository<T>) {
    super(repository);
  }

  getAllProductsByDeliverer(): Promise<T[]> {
    // TODO: need to change implementation
    return this.repository.find();
  }
}
