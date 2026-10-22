# Maintained in this repo. The Node patch pin is .nvmrc.
# Do not merge a Smithery regeneration that restores node:lts-alpine.
ARG NODE_VERSION=24.22.1
FROM node:${NODE_VERSION}-alpine AS build
WORKDIR /app
COPY package.json pnpm-lock.yaml .nvmrc ./
RUN version="$(tr -d '[:space:]' < .nvmrc)" && test "$version" = "$NODE_VERSION"
RUN corepack enable && pnpm install --frozen-lockfile
COPY . .
RUN pnpm build

FROM node:${NODE_VERSION}-alpine AS runtime
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN corepack enable && pnpm install --prod --frozen-lockfile
COPY --from=build /app/dist ./dist
CMD ["node", "dist/index.js"]
