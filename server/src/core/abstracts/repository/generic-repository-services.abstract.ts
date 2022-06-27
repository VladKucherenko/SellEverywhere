import { DeepPartial } from 'typeorm';

export abstract class IGenericRepository<T> {
  abstract getAll(): Promise<T[]>;

  abstract get(id: number): Promise<T>;

  abstract create(item: T): Promise<T>;

  abstract update(id: number, item: DeepPartial<T>);

  abstract deleteById(id: number): Promise<T>;
}
