# Use the base image for Golang
FROM golang:1.21.0-alpine as builder

# Install dependencies and build the binaries for lnd
RUN apk add --no-cache --update alpine-sdk git make gcc \
    && git clone https://github.com/uxuydev/lnd /go/src/github.com/uxuydev/lnd \
    && cd /go/src/github.com/uxuydev/lnd \
    && make release-install

# Build tapd
ARG tapd_checkout="v0.3.0"
ARG tapd_git_url="https://github.com/lightninglabs/taproot-assets"
RUN apk add --no-cache --update alpine-sdk git make gcc \
    && git clone $tapd_git_url /go/src/github.com/lightninglabs/taproot-assets \
    && cd /go/src/github.com/lightninglabs/taproot-assets \
    && git checkout $tapd_checkout \
    && make release-install

# Start a new, final image
FROM alpine

VOLUME ~/lntap/.lnd
VOLUME ~/lntap/.tapd
VOLUME ~/lntap/.taprooot-assets
VOLUME ~/lntap/logs

# Add utilities for quality of life and SSL-related reasons. We also require
# curl and gpg for the signature verification script.
RUN apk --no-cache add \
    bash \
    jq \
    ca-certificates \
    gnupg \
    curl \
    openrc

# Copy the binaries from the builder image
COPY --from=builder /go/bin/lncli /bin/
COPY --from=builder /go/bin/lnd /bin/
COPY --from=builder /go/bin/tapcli /bin/
COPY --from=builder /go/bin/tapd /bin/

# Create a Supervisor configuration file
#RUN echo_supervisord_conf > /etc/supervisord.conf && \
#    echo "[program:lnd]" >> /etc/supervisord.conf && \
#    echo "command=lnd" >> /etc/supervisord.conf && \
#    echo "[program:tapd]" >> /etc/supervisord.conf && \
#    echo "command=tapd" >> /etc/supervisord.conf

# Install Supervisor
#RUN apk add --no-cache supervisor

# Expose ports for lnd and tapd
#EXPOSE 9735 10009 10029 8089
EXPOSE 9736 10010 10029 8089

# Specify Supervisor as the entrypoint
#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
# COPY tls.cert /.lnd/tls.cert
# COPY tls.key /.lnd/tls.key
COPY start-lnd.sh /start-lnd.sh
COPY start-tapd.sh /start-tapd.sh
RUN chmod +x /start-lnd.sh
RUN chmod +x /start-tapd.sh

#docker run -it uxuy-lntap:latest /bin/sh

#RUN chmod +x /etc/init.d/lnd.service
#CMD ["/etc/init.d/lnd.service", "start"]

# ENTRYPOINT ["/start_services.sh"]

