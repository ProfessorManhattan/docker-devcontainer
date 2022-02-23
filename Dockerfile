FROM ubuntu:focal

ARG DOCKER_VERSION="latest"
ARG ENABLE_NONROOT_DOCKER="true"
ARG INSTALL_ZSH="true"
ARG PASSWORD="codingfor72hours"
ARG UPGRADE_PACKAGES="true"
ARG USE_MOBY="true"
ARG USER_GID="1111"
ARG USER_UID="1111"
ARG USERNAME="megabyte"

ENV BREW_PREFIX=/home/linuxbrew/.linuxbrew
ENV DBUS_SESSION_BUS_ADDRESS="autolaunch:"
ENV DISPLAY=":1"
ENV DOCKER_BUILDKIT=1
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
ENV NOVNC_PORT="6080"
ENV OSTYPE="linux-gnu"
ENV PATH=${BREW_PREFIX}/sbin:${BREW_PREFIX}/bin:${PATH}
ENV VNC_DPI="96"
ENV VNC_PORT="5901"
ENV VNC_RESOLUTION="1440x768x16"

VOLUME ["/work"]
WORKDIR /work

COPY scripts/*.sh /tmp/scripts/
COPY start.sh local/Brewfile .config Taskfile.yml ./

RUN apt-get update \
    && bash /tmp/scripts/common.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true"
RUN bash /tmp/scripts/desktop.sh "${USERNAME}" "${PASSWORD}" "true" "${VNC_PORT}" "${NOVNC_PORT}"
RUN bash /tmp/scripts/dind.sh "${ENABLE_NONROOT_DOCKER}" "${USERNAME}" "${USE_MOBY}" "${DOCKER_VERSION}"
RUN bash /tmp/scripts/sshd.sh "2222" "${USERNAME}" "false" "${PASSWORD}" "true"
RUN apt-get install -y --no-install-recommends sshfs
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && chown -R "${USERNAME}:${USERNAME}" ./

USER megabyte

RUN bash start.sh
RUN brew bundle install
RUN task install:go:bundle \
    && task install:rust:bundle
RUN task install:github:bundle \
    && task install:npm:bundle
RUN task install:pipx:bundle \
    && task install:apt:clean

COPY local/package.json local/pyproject.toml ./

RUN task install:python:requirements \
    && task install:modules:local

VOLUME ["/var/lib/docker"]

ENTRYPOINT ["/usr/local/share/desktop-init.sh", "/usr/local/share/ssh-init.sh", "/usr/local/share/docker-init.sh"]
CMD ["sleep", "infinity"]

ARG BUILD_DATE
ARG REVISION
ARG VERSION

LABEL maintainer="Megabyte Labs <help@megabyte.space>"
LABEL org.opencontainers.image.authors="Brian Zalewski <brian@megabyte.space>"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.description="The DevContainer Docker-based development environment for Megabyte Labs projects"
LABEL org.opencontainers.image.documentation="https://github.com/ProfessorManhattan/docker-devcontainer/blob/master/README.md"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision=$REVISION
LABEL org.opencontainers.image.source="[[ Injected by running `task update` ]]"
LABEL org.opencontainers.image.url="https://megabyte.space"
LABEL org.opencontainers.image.vendor="Megabyte Labs"
LABEL org.opencontainers.image.version=$VERSION
LABEL space.megabyte.type="software"
