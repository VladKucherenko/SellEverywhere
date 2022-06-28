import { Controller, Get } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { AppServicesService } from "../../services/use-cases/app/app-services.service";

@Controller()
export class AppController {
  constructor(
    private readonly appConfig: ConfigService,
    private readonly appService: AppServicesService,
  ) {}

  @Get()
  receivePong(): string {
    return this.appService.sendPing();
  }
}
