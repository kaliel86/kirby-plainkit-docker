FROM node:20-slim
RUN corepack enable
RUN corepack prepare pnpm@latest --activate
RUN mkdir -m 777 /.cache
