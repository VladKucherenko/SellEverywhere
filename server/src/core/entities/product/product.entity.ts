import { IBaseEntity } from '../base.entity';

export class IProductEntity extends IBaseEntity {
  id: number;
  product_name: string;
  description: string;
  price: number;
  amount: number;
}
