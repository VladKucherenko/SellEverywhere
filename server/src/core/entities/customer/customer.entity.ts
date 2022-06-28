import { IBaseEntity } from '../base.entity';

export class ICustomerEntity extends IBaseEntity {
  id: number;
  customer_role_id: number;
  username: string;
  first_name: string;
  last_name: string;
  email: string;
  phone: string;
}
