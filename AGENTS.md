# AGENTS.md

This repo is a thin stdio→HTTP proxy for the remote OP.GG MCP server. Tool
definitions live on the remote endpoint, not in this repo. See `README.md`
for the user-facing tool list.

## Project Map
- `src/index.ts`: entry point. Connects to the remote MCP endpoint and binds it to stdio.
- `src/proxy-server.ts`: generic capability bridge (tools, resources, prompts, logging, completion).
- `dist/`: build output from `tsup`. Git-ignored. Do not edit.
- `docs/apps-sdk/`, `docs/kakao/`: reference material only. Not part of the build.
- `.nvmrc`: the Node patch pin. CI and the image read this version.
- `Dockerfile`, `smithery.yaml`: Smithery runs the image. The Dockerfile is maintained in this repo so the Node pin and the pnpm frozen install survive regeneration.
- `.github/workflows/ci.yml`: pull-request build, typecheck, and live MCP initialize handshake.
- `.github/scripts/boot-proxy.sh`: sends one stdio `initialize` and requires `protocolVersion` in the result.
- `.github/dependabot.yml`: weekly npm group updates (`npm_and_yarn`) and the Docker ecosystem. The Node pin stays in `.nvmrc`; Dependabot does not rewrite an image version stored in `ARG`.
- `README.md`, `README.ko.md`, `README.ja.md`, `README.zh-CN.md`, `README.zh-TW.md`, `README.pt-BR.md`: keep the 6 language READMEs in sync.

## Commands
- Install: `pnpm install`.
- Build: `pnpm build` (runs `tsup`; emits ESM + `.d.ts` + sourcemap to `dist/`).
- Type check: `pnpm exec tsc --noEmit`.
- Run locally: `node dist/index.js` (requires `pnpm build` first).
- Smoke test with MCP Inspector: `pnpm test`. Requires `dist/index.js` to exist.

## Workflow Rules
- Use pnpm. Do not use npm or yarn. The lockfile is `pnpm-lock.yaml`. The pnpm version is `packageManager` in `package.json`.
- The Node version is `.nvmrc`. `actions/setup-node` uses `node-version-file: .nvmrc`. The image `ARG NODE_VERSION` default must match that file; CI and the image build both fail when they differ. `tsconfig.json` extends `@tsconfig/node22` for the TypeScript target.
- Use ESM only. `package.json` declares `"type": "module"` and `tsup.format` is `["esm"]`.
- The remote endpoint `https://mcp-api.op.gg/mcp` is hardcoded in `src/index.ts`. Do not change it without coordinating with the OP.GG MCP service owners.
- Do not declare MCP tools, resources, or prompts in this repo. The proxy forwards them from the remote server. Adding local definitions defeats the proxy and breaks parity with the remote.
- When the remote tool list changes, update all 6 README files together. The last sync commit was `3deb793 docs: update tool list to match latest MCP server`.
- The Dockerfile installs with `pnpm install --frozen-lockfile` (runtime: `--prod --frozen-lockfile`). Do not switch it back to `npm install`.
- Do not merge a Smithery regeneration that restores `node:lts-alpine` or drops the frozen install. The pin is the security patch in `.nvmrc`.
- Do not commit `dist/`, `node_modules/`, or `.env`. See `.gitignore`.

## Code Style
- TypeScript with `noUnusedLocals` and `noUnusedParameters` enabled. Remove unused identifiers; do not silence with `_` prefixes unless required by a callback signature.
- Import other source files with the `.js` extension, e.g. `import { proxyServer } from "./proxy-server.js"`. ESM resolution requires this even though the source is `.ts`.
- Use `node:` prefix for Node built-ins, matching existing imports (e.g. `import { setTimeout } from "node:timers"`).
- This project has no linter and no formatter. Match the existing 2-space indent and double-quoted strings in `src/`.

## Testing
- There is no unit test suite. Do not add Jest, Vitest, or similar without asking the owner first.
- Pull requests run `.github/workflows/ci.yml`: frozen install, `tsc --noEmit`, `pnpm build`, then a live `initialize` handshake against `https://mcp-api.op.gg/mcp` for both the workspace build and the image. An upstream outage fails this CI.
- `pnpm test` runs MCP Inspector against `dist/index.js`. It is not the CI gate.

## Commits and PRs
- Use Conventional Commits in English, lowercase type. Match the existing log: `feat:`, `fix:`, `docs:`, `chore:`.
- Keep the subject in present tense and under ~70 characters.
- Do not include `dist/` or `node_modules/` in any commit.
- Reference the remote tool inventory in the body when a commit syncs README tool tables.

## Do Not
- Do not use npm or yarn.
- Do not add tool, resource, or prompt definitions to this proxy.
- Do not change the hardcoded remote URL without coordination.
- Do not add CommonJS files, `.cjs`, or remove `"type": "module"`.
- Do not introduce environment variables. The proxy has no required env input today.
- Do not delete or rewrite `docs/apps-sdk/` or `docs/kakao/`. They are reference-only.
