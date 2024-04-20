import { InteractionResponseType, InteractionType } from "discord-interactions";
import { Handler } from "hono";

import { getGceInstanceClient } from "../../infra/client/gceInstance.js";
import { getInteractionMessageComponent } from "../../usecase/getInteractionMessageComponent.usecase.js";
import { getServerInfo } from "../../usecase/getServerInfo.usecase.js";
import { getStopServerModal } from "../../usecase/getStopServerModal.usecase.js";
import { startServer } from "../../usecase/startServer.usecase.js";
import { stopServer } from "../../usecase/stopServer.usecase.js";

/**
 * @see https://discord.com/developers/docs/interactions/application-commands
 */
export const interactionsHandler: Handler = async (c) => {
  try {
    // Interaction type and data
    const json = await c.req.json();
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const { type, data } = json as any;
    const gceInstanceClient = getGceInstanceClient();

    /**
     * Handle verification requests
     */
    if (type === InteractionType.PING) {
      return c.json({ type: InteractionResponseType.PONG });
    }

    /**
     * Handle slash command requests
     * See https://discord.com/developers/docs/interactions/application-commands#slash-commands
     */
    if (type === InteractionType.APPLICATION_COMMAND) {
      const { name } = data;
      switch (name) {
        case "palworld_server":
          return getInteractionMessageComponent({ c })();
        default:
          break;
      }
    }

    /**
     * Handle component interaction requests
     */
    if (type === InteractionType.MESSAGE_COMPONENT) {
      const { custom_id } = data;
      switch (custom_id) {
        case "start_server": {
          return startServer({ c, gceInstanceClient })();
        }
        case "get_server_info": {
          return getServerInfo({ c, gceInstanceClient })();
        }
        case "get_stop_server_modal": {
          return getStopServerModal({ c })();
        }
        default:
          break;
      }
    }

    /**
     * Handle modal interaction requests
     */
    if (type === InteractionType.MODAL_SUBMIT) {
      const { custom_id } = data;
      switch (custom_id) {
        case "stop_server": {
          return stopServer({ c, gceInstanceClient })();
        }
        default:
          break;
      }
    }
  } catch (error) {
    console.error(error);
  }
};
