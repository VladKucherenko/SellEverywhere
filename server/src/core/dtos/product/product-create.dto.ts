import { IsString, IsNotEmpty, IsNumber, IsOptional } from 'class-validator';

export class ProductCreateDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsOptional()
  description: string;

  @IsNumber()
  @IsOptional()
  priceNum: number;

  @IsNumber()
  @IsOptional()
  amount: number;
}
