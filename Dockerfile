FROM mwaeckerlin/nodejs AS copy

FROM mwaeckerlin/scratch AS production
ENV CONTAINERNAME "nexe"
ENV NODE_ENV 'production'
USER "${RUN_USER}"
WORKDIR /app
COPY --from=copy /lib /lib
COPY --from=copy /usr/lib /usr/lib
CMD ["/app/app", "--trace-uncaught"]
