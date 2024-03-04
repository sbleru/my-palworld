import { verifyKey } from "discord-interactions";
import { MiddlewareHandler } from "hono/types";

export const verifyDiscordRequest: MiddlewareHandler = async (c, next) => {
  const signature = c.req.header("X-Signature-Ed25519");
  const timestamp = c.req.header("X-Signature-Timestamp");
  const rawBody = await c.req.raw.clone().text();
  const clientKey = process.env.DISCORD_PUBLIC_KEY;

  const isValidRequest =
    signature &&
    timestamp &&
    clientKey &&
    verifyKey(rawBody, signature, timestamp, clientKey);
  if (!isValidRequest) {
    c.status(401);
    throw new Error("Bad request signature");
  }
  return await next();
};
