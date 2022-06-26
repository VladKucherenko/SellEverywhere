/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  env: {
    SELL_SERVER_HOST: process.env.SELL_SERVER_HOST,
  },
};

module.exports = nextConfig;
