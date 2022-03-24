FROM ubuntu:focal AS devcontainer

ARG DOCKER_VERSION="latest"
ARG ENABLE_NONROOT_DOCKER="true"
ARG INSTALL_ZSH="true"
ARG PASSWORD="labs"
ARG UPGRADE_PACKAGES="true"
ARG USE_MOBY="true"
ARG USER_GID="1000"
ARG USER_UID="1000"
ARG USERNAME="megabyte"

ENV BREW_PREFIX=/home/linuxbrew/.linuxbrew
ENV DBUS_SESSION_BUS_ADDRESS="autolaunch:"
ENV DISPLAY=":1"
ENV DOCKER_BUILDKIT=1
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"
ENV NOVNC_PORT="6080"
ENV OSTYPE="linux-gnu"
ENV PATH="$PATH:/usr/local/go/bin"
ENV VNC_DPI="96"
ENV VNC_PORT="5901"
ENV VNC_RESOLUTION="1440x768x16"

WORKDIR /work

COPY scripts/*.sh /tmp/scripts/
COPY bin/ /usr/local/bin/

SHELL ["/bin/bash", "-eo", "pipefail", "-c"]
RUN set -ex \
  && apt-get update \
  && apt-get upgrade -y \
  && bash /tmp/scripts/common.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
  && bash /tmp/scripts/desktop.sh "${USERNAME}" "${PASSWORD}" "true" "${VNC_PORT}" "${NOVNC_PORT}" \
  && bash /tmp/scripts/dind.sh "${ENABLE_NONROOT_DOCKER}" "${USERNAME}" "${USE_MOBY}" "${DOCKER_VERSION}" \
  && bash /tmp/scripts/sshd.sh "2222" "${USERNAME}" "false" "${PASSWORD}" "true" \
  && apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  file \
  gcc \
  git \
  grep \
  gzip \
  jo \
  jq \
  libnss3-tools \
  make \
  procps \
  rsync \
  ruby \
  sshfs \
  sshpass \
  sudo \
  systemd \
  systemd-cron \
  systemd-sysv \
  && apt-get clean \
  && rm -rf \
  /usr/share/doc \
  /usr/share/man \
  /tmp/* \
  /var/tmp/* \
  /var/lib/apt/lists/* \
  && rm -rf /var/lib/apt/lists/* \
  && curl -sL https://raw.githubusercontent.com/docker-slim/docker-slim/master/scripts/install-dockerslim.sh | sudo -E bash - \
  && curl -sSL https://golang.org/dl/go1.18.linux-amd64.tar.gz > /tmp/go.tar.gz \
  && tar -C /usr/local -xzf /tmp/go.tar.gz \
  && rm -rf /tmp/* \
  && touch /.devcontainer

USER "${USERNAME}"

WORKDIR /home/${USERNAME}

ENV GOPATH="/home/${USERNAME}/.local/go"
ENV PATH="${GOPATH}/bin:${BREW_PREFIX}/sbin:${BREW_PREFIX}/bin:/home/${USERNAME}/.local/bin:/home/${USERNAME}/.cargo/bin:${PATH}"

COPY start.sh .config Taskfile.yml ./

RUN set -ex \
  && sudo chown -R "${USERNAME}:${USERNAME}" . \
  && mkdir -p ~/.local/bin ~/.local/go ~/.cargo/bin \
  && curl https://sh.rustup.rs -sSf | sh -s -- -y \
  && START=false bash start.sh \
  && task \
  install:apt:gcloud \
  install:apt:gitlab-runner \
  install:apt:helm \
  install:apt:kubectl \
  install:apt:node \
  install:apt:packer \
  install:apt:python \
  install:apt:terraform \
  install:apt:vagrant \
  install:apt:waypoint \
  install:apt:yarn \
  && sudo chown -R "${USERNAME}:${USERNAME}" /usr/lib/node_modules \
  && sudo chown -R "${USERNAME}:${USERNAME}" . \
  && mkdir -p "$HOME/.local/go" \
  && task \
  install:go:bundle \
  install:npm:bundle \
  install:pipx:bundle \
  install:rust:bundle \
  install:software:poetry \
  && sudo chown -Rf "${USERNAME}:${USERNAME}" /home/megabyte \
  && sudo task \
  install:go:clean \
  install:rust:clean \
  && mkdir -p "$HOME/.local" \
  && git clone https://github.com/ingydotnet/git-subrepo "$HOME/.local/git-subrepo" \
  && echo 'source $HOME/.local/git-subrepo/.rc' >> ~/.bashrc \
  && rm -rf * \
  && sudo rm -rf /tmp/*

VOLUME ["/var/lib/docker"]

ENTRYPOINT ["/usr/local/share/desktop-init.sh", "/usr/local/share/ssh-init.sh", "/usr/local/share/docker-init.sh"]
CMD ["sleep", "infinity"]

ARG BUILD_DATE
ARG REVISION
ARG VERSION

LABEL maintainer="Megabyte Labs <help@megabyte.space>"
LABEL org.opencontainers.image.authors="Brian Zalewski <brian@megabyte.space>"
LABEL org.opencontainers.image.created=$BUILD_DATE
LABEL org.opencontainers.image.description="The Docker-based, DevContainer development environment for multi-language projects"
LABEL org.opencontainers.image.documentation="https://github.com/megabyte-labs/docker-devcontainer/blob/master/README.md"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.revision=$REVISION
LABEL org.opencontainers.image.source="https://github.com/megabyte-labs/docker-devcontainer.git"
LABEL org.opencontainers.image.url="https://megabyte.space"
LABEL org.opencontainers.image.vendor="Megabyte Labs"
LABEL org.opencontainers.image.version=$VERSION
LABEL space.megabyte.type="software"
