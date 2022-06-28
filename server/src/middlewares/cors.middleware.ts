import { Injectable, NestMiddleware } from '@nestjs/common';
import { NextFunction } from 'express';

@Injectable()
export class CorsMiddleware implements NestMiddleware {
  use(req: Request, res: Response, next: NextFunction) {
    // TODO: need to remove or change logic for cors
    const allowedOrigins = [
      'http://localhost:3005'
    ];
    if (allowedOrigins.indexOf(req.headers.get('Origin')) === -1) {
      res.headers.set('Access-Control-Allow-Origin', req.headers.get('Origin'));
      res.headers.set('Access-Control-Allow-Headers', 'content-type');
      res.headers.set('Access-Control-Allow-Methods', 'GET');
    }

    next();
  }
}
