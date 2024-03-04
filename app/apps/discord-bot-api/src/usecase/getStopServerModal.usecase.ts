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
 * Get stop server modal
 */
export const getStopServerModal =
  ({ c }: Deps) =>
  () => {
    return c.json({
      type: InteractionResponseType.MODAL,
      data: {
        title: "Are you sure you want to stop the server?",
        custom_id: "stop_server",
        components: [
          {
            type: 1,
            components: [
              {
                type: MessageComponentTypes.INPUT_TEXT,
                custom_id: "name",
                label:
                  "停止する（停止する場合はそのまま送信ボタンを押してください）",
                style: TextStyleTypes.SHORT,
                value: "stop",
                min_length: 4,
                max_length: 4,
                required: true,
              },
            ],
          },
        ],
      },
    });
  };
