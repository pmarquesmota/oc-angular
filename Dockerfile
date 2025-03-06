FROM alpine:3.21.3 AS builder
COPY . /srv
WORKDIR /srv
RUN --mount=type=cache,target=/var/cache/apk apk add npm
RUN --mount=type=cache,target=/srv/.npm npm ci --cache .npm --prefer-offline && \
  npm run build && \
  npm pack

FROM alpine:3.21.3
RUN --mount=type=cache,target=/var/cache/apk apk add nginx
EXPOSE 4200
COPY --from=builder /srv/nginx/nginx.conf /etc/nginx/
COPY --from=builder /srv/dist/olympic-games-starter /srv
ENTRYPOINT [ "/usr/sbin/nginx" ]
