import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';
import { BaseEntity } from './base.entity';

@Entity('product')
export class ProductEntity extends BaseEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', length: 100 })
  product_name: string;

  @Column({ type: 'varchar', length: 5000 })
  description: string;

  @Column({ type: 'numeric', precision: 7, scale: 2, default: 0 })
  price: number;

  @Column({ type: 'int', default: 0 })
  amount: number;
}
