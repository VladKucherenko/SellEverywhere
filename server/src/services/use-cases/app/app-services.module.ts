import { Module } from '@nestjs/common';
import { AppServicesService } from './app-services.service';

@Module({
  imports: [],
  providers: [AppServicesService],
  exports: [AppServicesService],
})
export class AppServicesModule {}
