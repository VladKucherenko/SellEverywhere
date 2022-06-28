import "../styles/globals.css";
import type { AppProps } from "next/app";
import { setUpInterceptors } from "../rest-services/axios/axios-interceptors";

function MyApp({ Component, pageProps }: AppProps) {
  return <Component {...pageProps} />;
}

setUpInterceptors();

export default MyApp;
