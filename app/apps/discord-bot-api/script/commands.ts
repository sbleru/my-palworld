import "dotenv/config";
import { InstallGlobalCommands } from "./utils";

const PALWORLD_SERVER_COMMAND = {
  name: "palworld_server",
  description: "Palworld server interaction message component",
  type: 1,
};

const ALL_COMMANDS = [PALWORLD_SERVER_COMMAND];

process.env.APP_ID && InstallGlobalCommands(process.env.APP_ID, ALL_COMMANDS);
