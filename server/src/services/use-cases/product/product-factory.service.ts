import { Injectable } from '@nestjs/common';
import { ProductCreateDto } from '../../../core/dtos/product/product-create.dto';
import { IProductEntity } from '../../../core/entities/product/product.entity';
import { ProductBasicDto } from '../../../core/dtos/product/product-basic.dto';

@Injectable()
export class ProductFactoryService {
  createNewEntity(productCreateDto: ProductCreateDto): IProductEntity {
    const productEntity = new IProductEntity();
    productEntity.name = productCreateDto.name;
    productCreateDto.description &&
      (productEntity.description = productCreateDto.description);
    productCreateDto.priceNum &&
      (productEntity.price = productCreateDto.priceNum);
    productCreateDto.amount && (productEntity.amount = productCreateDto.amount);

    return productEntity;
  }

  transformToObject(productEntity: IProductEntity): ProductBasicDto {
    const productObject = new ProductBasicDto();
    productObject.id = productEntity.id;
    productObject.name = productEntity.name;
    productObject.description = productEntity.description;
    productObject.priceNum = productEntity.price;
    productObject.amount = productEntity.amount;
    productObject.createdAt = productEntity.created_date;
    productObject.updatedAt = productEntity.updated_date;

    return productObject;
  }
}
