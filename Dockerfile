# Maintained in this repo. Both FROM lines must match .nvmrc.
# Do not merge a Smithery regeneration that restores node:lts-alpine.
FROM node:26.12.0-alpine AS build
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN corepack enable && pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

FROM node:26.12.0-alpine AS runtime
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN corepack enable && pnpm install --prod --frozen-lockfile
COPY --from=build /app/dist ./dist
CMD ["node", "dist/index.js"]
