import { Injectable } from '@nestjs/common';

@Injectable()
export class AppServicesService {
  sendPing(): string {
    return 'Pong';
  }
}
