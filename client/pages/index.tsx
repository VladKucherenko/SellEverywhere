import type { NextPage } from "next";
import Head from "next/head";
import { useEffect, useState } from "react";

import { httpClient } from "../rest-services/axios/axios-instance";
import styles from "../styles/Home.module.css";

const initialData = [
  {
    id: 1,
    name: "Iphone 12",
    description: "Find in-depth information about Iphone features and price.",
    priceNum: "1000$",
    amount: "3",
  },
  {
    id: 2,
    name: "Iphone 13",
    description: "Find in-depth information about Iphone features and price.",
    priceNum: "1000$",
    amount: "3",
  },
  {
    id: 3,
    name: "Iphone 14",
    description: "Find in-depth information about Iphone features and price.",
    priceNum: "1000$",
    amount: "3",
  },
  {
    id: 4,
    name: "Iphone 15",
    description: "Find in-depth information about Iphone features and price.",
    priceNum: "1000$",
    amount: "3",
  },
];

interface ProductCard {
  id: number, 
  name: string, 
  description: string, 
  priceNum: string,
  amount: string
}

type Props = {
  item?: ProductCard
}

const ProductCard = ({item}: Props) => {
  // const {item: ProductCard} = props;

  return (
    <div className={styles.card}>
      <h2>{item?.name}</h2>
      <p>{item?.description}</p>
      <p>{item?.priceNum}</p>
    </div>
  );
};

const Home: NextPage = () => {
  const [res, setRes] = useState(initialData);

  useEffect(() => {
    getterInfo();
  }, []);

  const getterInfo = async () => {
    const res = await httpClient.get("products");
    setRes(res.data);
  };

  return (
    <div className={styles.container}>
      <Head>
        <title>MKDIR</title>
        <meta name="description" content="Generated by create next app" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>SELL EVERYWHERE</h1>

        <p className={styles.description}>MALIUKH & KUCHERENKO & MELNYCHUK</p>
        <code className={styles.code}>shop of your dream</code>

        <div className={styles.grid}>
          {res.map((resItem) => (
            <ProductCard key={resItem?.id} item={resItem} />
          ))}
        </div>
      </main>
    </div>
  );
};

export default Home;
