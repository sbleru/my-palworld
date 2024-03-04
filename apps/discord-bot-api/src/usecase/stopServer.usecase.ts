import {
  ButtonStyleTypes,
  InteractionResponseType,
  MessageComponentTypes,
  TextStyleTypes,
} from "discord-interactions";
import { Context } from "hono";

type Deps = {
  c: Context;
};

/**
 * Stop server
 */
export const stopServer =
  ({ c }: Deps) =>
  () => {
    return c.json({
      type: InteractionResponseType.CHANNEL_MESSAGE_WITH_SOURCE,
      data: {
        // Fetches a random emoji to send from a helper function
        content: "Palworld server: ",
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
