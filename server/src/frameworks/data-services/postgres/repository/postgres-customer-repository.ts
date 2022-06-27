import { Repository } from 'typeorm';
import { PostgresGenericRepository } from './postgres-generic-repository';
import { ICustomerRepository } from "../../../../core/abstracts/repository/customer-repository-services.abstract";

export class PostgresCustomerRepository<T>
  extends PostgresGenericRepository<T>
  implements ICustomerRepository<T>
{
  repository: Repository<T>;

  constructor(repository: Repository<T>) {
    super(repository);
  }

  getOne(id: number): Promise<T> {
    // TODO: need to change implementation
    return this.repository.findOne(id);
  }
}
