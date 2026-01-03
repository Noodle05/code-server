FROM docker:latest AS docker-cli-builder

FROM lscr.io/linuxserver/code-server:latest

ARG GO_VERSION=1.25.5
ARG TARGETARCH
ARG GO_DOWNLOAD_URL=https://go.dev/dl/go${GO_VERSION}.linux-${TARGETARCH}.tar.gz

ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/config/go

# Copy the docker client binary from the builder stage
COPY --from=docker-cli-builder /usr/local/bin/docker /usr/local/bin/docker

RUN mkdir /custom-cont-init.d \
 && curl -L "${GO_DOWNLOAD_URL}" | tar zx -C /usr/local/

COPY --chmod=0755 install_go_extensions.sh /custom-cont-init.d/install_go_extensions.sh
COPY --chmod=0755 add_docker_group.sh /custom-cont-init.d/add_docker_group.sh
