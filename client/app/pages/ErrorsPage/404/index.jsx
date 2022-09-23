// import { Layout } from "@shared/ui";
import Error from "../../../shared/ui";

export const Custom404 = () => (
  // <Layout pageName="404" withBreadcrumbs={false}>
    <Error errorCode={404} />
  // </Layout>
);
