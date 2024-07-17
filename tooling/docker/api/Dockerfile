# dummy update
# turborepoを利用したDockerfile構成
# 対象のappに関わるものだけでmonorepoを構成する
# monorepoとdocker
# - https://turbo.build/repo/docs/handbook/deploying-with-docker
# - https://github.com/vercel/turbo/tree/main/examples/with-docker
# - https://github.com/fvst-dev/fvst-monorepo
# prune
# - https://turbo.build/repo/docs/reference/command-line-reference/prune

# base ステージ（共通の設定）
FROM node:20-alpine AS base

# builder ステージ
FROM base AS builder
# see https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat
RUN apk update
WORKDIR /app
RUN npm install -g turbo
# .dockerignore の内容以外をコンテナへコピーする
COPY . .
# turbo prune によって部分的なmonorepoを作成する
RUN turbo prune --scope=api --docker;

# installer ステージ
# builderで prune によって作成された部分的なmonrepoを、installerへコピー
# Add lockfile and package.json's of isolated subworkspace
FROM base AS installer
RUN apk add --no-cache libc6-compat
RUN apk update
WORKDIR /app
# 最小限の依存でnpm installを行う
COPY .gitignore .gitignore
COPY --from=builder /app/out/json/ .
COPY --from=builder /app/out/package-lock.json ./package-lock.json
RUN corepack enable npm
RUN npm install
# builderでpruneによって作成されたフルのコードをinstallerへコピーし、ビルドする
COPY --from=builder /app/out/full/ .
COPY turbo.json turbo.json
RUN npx turbo run build --filter=api...;

# runner ステージ （アプリケーションを実行する）
FROM base AS runner
WORKDIR /app
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 hono
COPY --from=installer /app .
USER hono
EXPOSE 3000
CMD ["node", "/app/apps/api/dist/index.js"]
