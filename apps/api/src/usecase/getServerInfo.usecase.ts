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
 * Get server info
 */
export const getServerInfo =
  ({ c, gceInstanceClient }: Deps) =>
  async () => {
    const instance = await gceInstanceClient.get();

    return c.json({
      type: InteractionResponseType.UPDATE_MESSAGE,
      data: {
        // Fetches a random emoji to send from a helper function
        content: `
Palworld server
Status: ${instance.status}
IP Address: ${instance.externalIp}
        `,
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
              // Show stop button only when the server is running
              ...(instance.status === "RUNNING"
                ? [
                    {
                      type: MessageComponentTypes.BUTTON,
                      label: "Stop Server",
                      style: ButtonStyleTypes.DANGER,
                      custom_id: "get_stop_server_modal",
                    },
                  ]
                : []),
            ],
          },
        ],
      },
    });
  };
