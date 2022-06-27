import { IBaseEntity } from '../base.entity';

export class IProductEntity extends IBaseEntity {
  id: number;
  name: string;
  description: string;
  price: number;
  amount: number;
}
