import { IBaseEntity } from '../base.entity';

export class IProductEntity extends IBaseEntity {
  id: string;

  name: string;

  description: string | null;

  price: number;

  amount: number;
}
