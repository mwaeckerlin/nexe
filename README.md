# Docker Image for Nexe Compiled Node.JS Projects.

Use [mwaeckerlin/nodejs-build](https://github.com/mwaeckerlin/nodejs-build) for building the images. If you use `nexe` to compile the result into a single file, then use this image as base instead of [mwaeckerlin/nodejs](https://github.com/mwaeckerlin/nodejs).

The image does not have a shell nor an package manager, but only the shared libraries required for nexe.

Usage example:

```Dockerfile
ARG DOCKER_REPOSITORY
ARG DOCKER_TAG
FROM mwaeckerlin/nestjs-build AS build
COPY --chown=${BUILD_USER} . .
RUN npm install
RUN npm run build
ENV NODE_ENV 'production'
RUN find -name node_modules -prune -exec rm -rf {} \;
RUN npm install
RUN nexe --build --python=$(which python3) -r "temp" -r "dist/migrations" -o app dist/src/main.js

FROM mwaeckerlin/nexe AS production
EXPOSE 4460
ENV CONTAINERNAME "bridging"
COPY --from=build /app/backends/bridging/app /app/app
```