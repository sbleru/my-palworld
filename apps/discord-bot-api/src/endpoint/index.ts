import { serve } from "@hono/node-server";
import { Hono } from "hono";
import { verifyDiscordRequest } from "./middleware/verifyDiscordRequest";
import { interactionsHandler } from "./handler/interactions";

export const startServer = async () => {
  const app = new Hono();

  app.get("/", (c) => {
    return c.text("Hello Hono!");
  });

  app.use(verifyDiscordRequest);

  app.post("/interactions", interactionsHandler);

  const port = 3000;
  console.log(`Server is running on port ${port}`);

  serve({
    fetch: app.fetch,
    port,
  });
};
