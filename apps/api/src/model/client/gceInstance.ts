export type GceInstanceClientInterface = {
  get: () => Promise<GceInstance>;
  start: () => Promise<void>;
  stop: () => Promise<void>;
};

export type GceInstance = {
  name: string;
  status: string | undefined;
  externalIp: string;
};
