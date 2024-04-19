import { serve } from "@hono/node-server";
import { Hono } from "hono";

import { interactionsHandler } from "./handler/interactions.js";
import { verifyDiscordRequest } from "./middleware/verifyDiscordRequest.js";

export const startServer = async () => {
  const app = new Hono();

  app.get("/", (c) => {
    return c.text("Hello Hono!");
  });

  app.post("/interactions", verifyDiscordRequest, interactionsHandler);

  const port = 3000;
  console.log(`Server is running on port ${port}`);

  serve({
    fetch: app.fetch,
    port,
  });
};
