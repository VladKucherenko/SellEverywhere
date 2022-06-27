import { Injectable } from '@nestjs/common';

import { ProductFactoryService } from './product-factory.service';
import { IDataServices } from '../../../core/abstracts/data-services.abstract';
import { ProductBasicDto } from '../../../core/dtos/product/product-basic.dto';
import { ProductCreateDto } from '../../../core/dtos/product/product-create.dto';

@Injectable()
export class ProductServicesService {
  constructor(
    private dataServices: IDataServices,
    private productFactoryService: ProductFactoryService,
  ) {}

  async getAllProducts(): Promise<ProductBasicDto[]> {
    const productEntityList = await this.dataServices.products.getAll();
    const productList = productEntityList.map((productEntity) => {
      return this.productFactoryService.transformToObject(productEntity);
    });

    return productList;
  }
  async createNewProduct(
    productInfo: ProductCreateDto,
  ): Promise<ProductBasicDto> {
    const productToCreate =
      this.productFactoryService.createNewEntity(productInfo);

    const productEntity = await this.dataServices.products.create(
      productToCreate,
    );

    const productToObject =
      this.productFactoryService.transformToObject(productEntity);

    return productToObject;
  }
}
