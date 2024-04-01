import {
  ButtonStyleTypes,
  InteractionResponseType,
  MessageComponentTypes,
} from "discord-interactions";
import { Context } from "hono";

type Deps = {
  c: Context;
};

/**
 * Get interaction Discord Bot with palworld server
 */
export const getInteractionMessageComponent =
  ({ c }: Deps) =>
  () => {
    return c.json({
      type: InteractionResponseType.CHANNEL_MESSAGE_WITH_SOURCE,
      data: {
        // Fetches a random emoji to send from a helper function
        content: "Hello! This is palworld server bot.",
        components: [
          {
            type: 1,
            components: [
              {
                type: MessageComponentTypes.BUTTON,
                label: "Start server",
                style: ButtonStyleTypes.PRIMARY,
                custom_id: "start_server",
              },
            ],
          },
        ],
      },
    });
  };
