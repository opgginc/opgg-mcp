#!/usr/bin/env node

import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { EventSource } from "eventsource";
import { setTimeout } from "node:timers";
import util from "node:util";
import { proxyServer } from "./proxy-server.js";
import { StreamableHTTPClientTransport } from '@modelcontextprotocol/sdk/client/streamableHttp.js';
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";

util.inspect.defaultOptions.depth = 8;

if (!("EventSource" in global)) {
  // @ts-expect-error - figure out how to use --experimental-eventsource with vitest
  global.EventSource = EventSource;
}

const proxy = async (url: string): Promise<void> => {
  const client = new Client(
    {
      name: "ssl-client",
      version: "1.0.0",
    },
    {
      capabilities: {},
    },
  );

  const transport = new StreamableHTTPClientTransport(new URL(url));
  await client.connect(transport);

  const serverVersion = client.getServerVersion() as {
    name: string;
    version: string;
  };
  const serverCapabilities = client.getServerCapabilities() as {};
  
  const server = new Server(serverVersion, {
    capabilities: serverCapabilities,
  });

  const stdioTransport = new StdioServerTransport();
  await server.connect(stdioTransport);

  await proxyServer({
    server,
    client,
    serverCapabilities,
  });
};

const main = async () => {
  process.on("SIGINT", () => {
    console.info("SIGINT received, shutting down");

    setTimeout(() => {
      process.exit(0);
    }, 1000);
  });

  try {
    await proxy("https://mcp-api.op.gg/mcp");
  } catch (error) {
    console.error("could not start the proxy", error);

    setTimeout(() => {
      process.exit(1);
    }, 1000);
  }
};

await main();
