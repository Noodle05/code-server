FROM docker:latest AS docker-cli-builder

FROM lscr.io/linuxserver/code-server:latest

# Copy the docker client binary from the builder stage
COPY --from=docker-cli-builder /usr/local/bin/docker /usr/local/bin/docker

RUN apt-get update \
 && apt-get install -y golang git \
 && apt-get clean \
 && rm -fr /var/lib/apt/lists/* \
 && mkdir /custom-cont-init.d

ENV GOPATH=/config/go
ENV PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

COPY --chmod=0755 install_go_extensions.sh /custom-cont-init.d/install_go_extensions.sh
COPY --chmod=0755 add_docker_group.sh /custom-cont-init.d/add_docker_group.sh
