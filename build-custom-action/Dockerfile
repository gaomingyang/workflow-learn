# to build-custom-action
FROM alpine

RUN apk add --no-cache \
        bash \
        httpie \
        jq && \
        which bash && \
        which http && \
        which jq

COPY entrypoint.sh /usr/loca/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]