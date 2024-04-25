import { InstancesClient } from "@google-cloud/compute";

import { GceInstanceClientInterface } from "../../model/client/gceInstance.js";

const instanceClient = ({
  client,
  projectId,
  instanceName,
  zone,
}: {
  client: InstancesClient;
  projectId: string;
  instanceName: string;
  zone: string;
}): GceInstanceClientInterface => {
  return {
    get: async () => {
      const [instance] = await client.get({
        project: projectId,
        instance: instanceName,
        zone,
      });
      const externalIp =
        instance.networkInterfaces?.[0]?.accessConfigs?.[0].natIP;
      return {
        name: instance.name ?? "",
        status: instance.status ?? undefined,
        externalIp: externalIp ?? "N/A",
      };
    },
    start: async () => {
      await client.start({
        project: projectId,
        instance: instanceName,
        zone,
      });
    },
    stop: async () => {
      await client.stop({
        project: projectId,
        instance: instanceName,
        zone,
      });
    },
  };
};

export const getGceInstanceClient = () => {
  return instanceClient({
    client: new InstancesClient(),
    projectId: "boreal-atom-412606",
    instanceName: "palworld-server",
    zone: "asia-northeast1-a",
  });
};
