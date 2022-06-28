import { ProductCreateDto } from './product-create.dto';
import { PartialType } from '@nestjs/mapped-types';

export class ProductUpdateDto extends PartialType(ProductCreateDto) {}
