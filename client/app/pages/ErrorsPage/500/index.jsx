// import { Layout } from "@shared/ui";
import Error from "../../../shared/ui";

export const Custom500 = ({ t }) => (
  // <Layout pageName="500" withBreadcrumbs={false}>
    <Error errorCode={500} trans={t} />
  // </Layout>
);
