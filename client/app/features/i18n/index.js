import { serverSideTranslations } from "next-i18next/serverSideTranslations";

const gspWithtranslation = callback => async ctx => {
  const defaultResult = (await callback?.(ctx)) || {
    props: {},
    revalidate: 30
  };

  const resultedProps = Object.assign(
    defaultResult.props,
    await serverSideTranslations(ctx.locale)
  );

  defaultResult.props = resultedProps;

  if (!defaultResult?.revalidate) {
    defaultResult.revalidate = 30;
  }

  return defaultResult;
};

export default gspWithtranslation;
