/** @type {import('next').NextConfig} */

const { i18n } = require("./next-i18next.config");

const nextConfig = {
  reactStrictMode: true,
  i18n,
  env: {
    SELL_SERVER_HOST: process.env.SELL_SERVER_HOST,
  },
};

module.exports = nextConfig;
