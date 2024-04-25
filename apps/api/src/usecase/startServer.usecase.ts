import {
  ButtonStyleTypes,
  InteractionResponseType,
  MessageComponentTypes,
} from "discord-interactions";
import { Context } from "hono";

import { GceInstanceClientInterface } from "../model/client/gceInstance.js";

type Deps = {
  c: Context;
  gceInstanceClient: GceInstanceClientInterface;
};

/**
 * Start server
 */
export const startServer =
  ({ c, gceInstanceClient }: Deps) =>
  async () => {
    await gceInstanceClient.start();
    return c.json({
      type: InteractionResponseType.UPDATE_MESSAGE,
      data: {
        // Fetches a random emoji to send from a helper function
        content: "Palworld server started",
        components: [
          {
            type: 1,
            components: [
              {
                type: MessageComponentTypes.BUTTON,
                label: "Get server info",
                style: ButtonStyleTypes.PRIMARY,
                custom_id: "get_server_info",
              },
              {
                type: MessageComponentTypes.BUTTON,
                label: "Stop Server",
                style: ButtonStyleTypes.DANGER,
                custom_id: "get_stop_server_modal",
              },
            ],
          },
        ],
      },
    });
  };
