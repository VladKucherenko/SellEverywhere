import { Injectable, OnApplicationBootstrap } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { IDataServices } from '../../../core/abstracts/data-services.abstract';
import { PostgresProductRepository } from './repository/postgres-product-repository';
import { IProductEntity } from '../../../core/entities/product/product.entity';
import { ProductEntity } from './entities/product.entity';

@Injectable()
export class PostgresDataServices
  implements IDataServices, OnApplicationBootstrap
{
  products: PostgresProductRepository<IProductEntity>;

  constructor(
    @InjectRepository(ProductEntity)
    private ProductRepository: Repository<ProductEntity>,
  ) {}

  onApplicationBootstrap() {
    this.products = new PostgresProductRepository<ProductEntity>(
      this.ProductRepository,
    );
  }
}
