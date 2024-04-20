import "dotenv/config";

export async function DiscordRequest(
  endpoint: string,
  options: {
    method: "GET" | "POST" | "PUT" | "PATCH" | "DELETE";
    body: any;
  },
) {
  // append endpoint to root API URL
  const url = "https://discord.com/api/v10/" + endpoint;
  // Stringify payloads
  if (options.body) options.body = JSON.stringify(options.body);
  // Use node-fetch to make requests
  const res = await fetch(url, {
    headers: {
      Authorization: `Bot ${process.env.DISCORD_TOKEN}`,
      "Content-Type": "application/json; charset=UTF-8",
      "User-Agent":
        "DiscordBot (https://github.com/discord/discord-example-app, 1.0.0)",
    },
    ...options,
  });
  // throw API errors
  if (!res.ok) {
    const data = await res.json();
    console.log(res.status);
    throw new Error(JSON.stringify(data));
  }
  // return original response
  return res;
}

/**
 * @see https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-global-application-commands
 */
export async function InstallGlobalCommands(
  appId: string,
  commands: CreateGlobalApplicationCommand[],
) {
  // API endpoint to overwrite global commands
  const endpoint = `applications/${appId}/commands`;

  try {
    // This is calling the bulk overwrite endpoint: https://discord.com/developers/docs/interactions/application-commands#bulk-overwrite-global-application-commands
    await DiscordRequest(endpoint, { method: "PUT", body: commands });
  } catch (err) {
    console.error(err);
  }
}

interface CreateGlobalApplicationCommand {
  name: string;
  description: string;
  options?: CommandOption[];
  default_permission?: boolean;
}

interface CommandOption {
  type: number;
  name: string;
  description: string;
  required?: boolean;
  choices?: OptionChoice[];
  options?: CommandOption[];
}

interface OptionChoice {
  name: string;
  value: string | number;
}
