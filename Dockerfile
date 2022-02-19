FROM mcr.microsoft.com/vscode/devcontainers/base:0-buster

ARG DOCKER_VERSION="latest"
ARG ENABLE_NONROOT_DOCKER="true"
ARG INSTALL_ZSH="true"
ARG PASSWORD="codingfor72hours"
ARG UPGRADE_PACKAGES="false"
ARG USERNAME="megabyte"
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG USE_MOBY="true"

ENV DOCKER_BUILDKIT=1
ENV BREW_PREFIX=/home/linuxbrew/.linuxbrew
ENV PATH=${BREW_PREFIX}/sbin:${BREW_PREFIX}/bin:${PATH}
ENV DBUS_SESSION_BUS_ADDRESS="autolaunch:"
ENV VNC_RESOLUTION="1440x768x16"
ENV VNC_DPI="96"
ENV VNC_PORT="5901"
ENV NOVNC_PORT="6080"
ENV DISPLAY=":1"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

VOLUME ["/work"]
WORKDIR /work

COPY scripts/*.sh /tmp/scripts/
COPY start.sh local/Brewfile .config Taskfile.yml ./

RUN apt-get update \
    && bash /tmp/scripts/common.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    && bash /tmp/scripts/desktop.sh "${USERNAME}" "${PASSWORD}" "true" "${VNC_PORT}" "${NOVNC_PORT}" \
    && bash /tmp/scripts/dind.sh "${ENABLE_NONROOT_DOCKER}" "${USERNAME}" "${USE_MOBY}" "${DOCKER_VERSION}" \
    && bash /tmp/scripts/homebrew.sh "${USERNAME}" "true" "false" "${BREW_PREFIX}" \
    && bash /tmp/scripts/sshd.sh "2222" "${USERNAME}" "false" "${PASSWORD}" "true" \
    && apt-get install -y sshfs \
    && chown -R "${USERNAME}:${USERNAME}" ./

USER megabyte

RUN bash start.sh \
    && brew bundle install \
    && task install:go:bundle \
    && task install:rust:bundle \
    && task install:github:bundle \
    && task install:npm:bundle \
    && task install:pipx:bundle \
    && task install:apt:clean

COPY local/package.json local/pyproject.toml ./

RUN task install:python:requirements \
    && task install:modules:local

VOLUME ["/var/lib/docker"]

ENTRYPOINT ["/usr/local/share/desktop-init.sh", "/usr/local/share/ssh-init.sh", "/usr/local/share/docker-init.sh"]
CMD ["sleep", "infinity"]
