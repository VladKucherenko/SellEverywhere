// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
// import type { NextApiRequest, NextApiResponse } from 'next'

// type Data = {
//   name: string
// }

// export default function handler(
//   req: NextApiRequest,
//   res: NextApiResponse<Data>
// ) {
//   res.status(200).json({ name: 'John Doe' })
// }

import { SELL_SERVER_HOST } from "../../app/shared/config";

async function fetcher(path, options) {
  try {
    const data = await fetch(`${SELL_SERVER_HOST}/${path}`, options);
    console.info("Success request");
    return data.json();
  } catch (err) {
    // eslint-disable-next-line no-console
    console.warn("Fecther error: ", { path, msg: err?.message });
  }
}

export { fetcher };
