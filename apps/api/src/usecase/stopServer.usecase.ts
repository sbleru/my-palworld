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
 * Stop server
 */
export const stopServer =
  ({ c, gceInstanceClient }: Deps) =>
  async () => {
    await gceInstanceClient.stop();
    return c.json({
      type: InteractionResponseType.CHANNEL_MESSAGE_WITH_SOURCE,
      data: {
        // Fetches a random emoji to send from a helper function
        content: "Palworld server is stopping.",
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
            ],
          },
        ],
      },
    });
  };
