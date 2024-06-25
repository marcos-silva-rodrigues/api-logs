FROM debian

USER root

COPY ./client.sh /scripts/client.sh

RUN apt update && \
        apt install curl jq -y && \
        chmod +x /scripts/client.sh

ENTRYPOINT ["/scripts/client.sh"]