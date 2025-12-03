FROM docker:latest AS docker-cli-builder

FROM --platform=$BUILDPLATFORM debian:latest AS gradle-builder

ARG GRADLE_VERSION=9.2.1
ARG GRADLE_HOME=/usr/local/gradle

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends  unzip curl ca-certificates \
 && apt-get clean  all \
 && rm -fr /var/lib/{apt,dpkg,cache,log} \
 && curl -L -o /tmp/gradle.zip "https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip" \
 && unzip /tmp/gradle.zip -d /usr/local/ \
 && mv "/usr/local/gradle-$GRADLE_VERSION" "$GRADLE_HOME" \
 && rm /tmp/gradle.zip

FROM lscr.io/linuxserver/code-server:latest

ARG TARGETARCH

ARG OPENJDK_RELEASE=25
ARG OPENJDK_VERSION=25.0.1
ARG OPENJDK_VAR=8
ENV JAVA_HOME=/usr/local/java
ENV PATH=$PATH:$JAVA_HOME/bin

ARG MAVEN_VERSION=3.9.11
ENV MAVEN_HOME=/usr/local/maven
ENV PATH=$PATH:$MAVEN_HOME/bin

ARG GRADLE_VERSION=9.2.1
ENV GRADLE_HOME=/usr/local/gradle
ENV PATH=$PATH:$GRADLE_HOME/bin

# Copy the docker client binary from the builder stage
COPY --from=docker-cli-builder /usr/local/bin/docker /usr/local/bin/docker
COPY --from=gradle-builder "$GRADLE_HOME" "$GRADLE_HOME"

RUN mkdir /custom-cont-init.d \
 && if [ "$TARGETARCH" = "arm64" ]; then \
      curl -L "https://github.com/adoptium/temurin${OPENJDK_RELEASE}-binaries/releases/download/jdk-${OPENJDK_VERSION}%2B${OPENJDK_VAR}/OpenJDK${OPENJDK_RELEASE}U-jdk_aarch64_linux_hotspot_${OPENJDK_VERSION}_${OPENJDK_VAR}.tar.gz" | tar zx -C /usr/local; \
    else \
      curl -L "https://github.com/adoptium/temurin${OPENJDK_RELEASE}-binaries/releases/download/jdk-${OPENJDK_VERSION}%2B${OPENJDK_VAR}/OpenJDK${OPENJDK_RELEASE}U-jdk_x64_linux_hotspot_${OPENJDK_VERSION}_${OPENJDK_VAR}.tar.gz" | tar zx -C /usr/local; \
    fi \
 && mv "/usr/local/jdk-${OPENJDK_VERSION}+${OPENJDK_VAR}" "$JAVA_HOME" \
 && curl -L "https://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | tar zx -C /usr/local \
 && mv "/usr/local/apache-maven-$MAVEN_VERSION" "$MAVEN_HOME"

COPY --chmod=0755 install_go_extensions.sh /custom-cont-init.d/install_go_extensions.sh
COPY --chmod=0755 add_docker_group.sh /custom-cont-init.d/add_docker_group.sh
