import { Custom500 } from "../app/pages";

function Error() {
  return <Custom500 />;
}

Error.getInitialProps = async ({ res, err }) => {
  // eslint-disable-next-line no-nested-ternary
  const statusCode = res ? res.statusCode : err ? err.statusCode : 404;
  return { statusCode };
};

export default Error;
