import axios from "axios";

export const httpClient = axios.create({
  baseURL: process.env.SELL_SERVER_HOST,
  withCredentials: true,
});
