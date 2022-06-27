import { IGenericRepository } from '../../../../core/abstracts/repository/generic-repository-services.abstract';
import { DeepPartial, Repository } from 'typeorm';

export class PostgresGenericRepository<T> implements IGenericRepository<T> {
  repository: Repository<T>;

  constructor(repository: Repository<T>) {
    this.repository = repository;
  }

  getAll(): Promise<T[]> {
    return this.repository.find();
  }

  get(id: number): Promise<T> {
    return this.repository.findOne(id);
  }

  create(item: T): Promise<T> {
    return this.repository.save(item as DeepPartial<T>);
  }

  async update(id: number, item: DeepPartial<T>) {
    const foundedItem = await this.repository.findOne(id);
    return this.repository.save({ ...item, ...foundedItem });
  }

  async deleteById(id: number): Promise<T> {
    const deletedItem = await this.repository.findOne(id);
    await this.repository.delete(id);
    return deletedItem;
  }
}
