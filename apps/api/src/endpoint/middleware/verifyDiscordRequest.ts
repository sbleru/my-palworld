import { verifyKey } from "discord-interactions";
import { MiddlewareHandler } from "hono/types";

export const verifyDiscordRequest: MiddlewareHandler = async (c, next) => {
  const signature = c.req.header("X-Signature-Ed25519");
  const timestamp = c.req.header("X-Signature-Timestamp");
  // Required to clone. see https://github.com/honojs/hono/issues/1499#issuecomment-1732231455
  const rawBody = await c.req.raw.clone().text();
  const clientKey = process.env.DISCORD_PUBLIC_KEY;

  const isValidRequest =
    signature &&
    timestamp &&
    clientKey &&
    verifyKey(rawBody, signature, timestamp, clientKey);
  if (!isValidRequest) {
    c.status(401);
    return await next();
  }
  return await next();
};
