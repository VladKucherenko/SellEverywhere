import axios from "axios";
import { SELL_SERVER_HOST } from "../../app/shared/config";

export const httpClient = axios.create({
  baseURL: SELL_SERVER_HOST,
  withCredentials: true,
});
