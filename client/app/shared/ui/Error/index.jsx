/* eslint-disable react/jsx-props-no-spreading */
import { useTranslation } from "next-i18next";

import { Button, CustomLink, Flex, Text } from "..";

import styles from "./styles.module.scss";

const Error = ({ errorCode }) => {
  const { t } = useTranslation();
  return (
    <div className={styles.container}>
      <Flex direction="column" gap={16}>
        <h1 className={styles.heading}>
          {`Ошибка ${errorCode}`}
          <br />
          {errorCode === 404 ? t("error404_text") : "Произошел небольшой сбой"}
        </h1>
        <Text
          size="font-14"
          color="black"
          weight="regular"
          customStyles={styles.description}
        >
          {errorCode === 404
            ? t("error404_desc")
            : "Возникла небольшая ошибка. Попробуйте перезагрузить страницу."}
        </Text>

        <CustomLink href="/">
          <Button rounded>Перейти на главную</Button>
        </CustomLink>
      </Flex>
    </div>
  );
};

export default Error;
