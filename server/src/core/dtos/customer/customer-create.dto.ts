import { IsString, IsNotEmpty } from 'class-validator';

export class CustomerCreateDto {
  @IsString()
  @IsNotEmpty()
  customerRoleId: number;

  @IsString()
  @IsNotEmpty()
  username: string;

  @IsString()
  @IsNotEmpty()
  firstName: string;

  @IsString()
  @IsNotEmpty()
  lastName: string;

  @IsString()
  @IsNotEmpty()
  email: string;

  @IsString()
  @IsNotEmpty()
  phone: string;
}
