<!-- ⚠️ This README has been generated from the file(s) ".config/docs/blueprint-readme-software.md" ⚠️-->{{ load:.config/docs/readme/header.md }}
<div align="center">
  <a href="https://megabyte.space" title="Megabyte Labs homepage" target="_blank">
    <img alt="Homepage" src="https://img.shields.io/website?down_color=%23FF4136&down_message=Down&label=Homepage&logo=home-assistant&logoColor=white&up_color=%232ECC40&up_message=Up&url=https%3A%2F%2Fmegabyte.space&style=for-the-badge" />
  </a>
  <a href="https://github.com/ProfessorManhattan/docker-devcontainer/blob/master/docs/CONTRIBUTING.md" title="Learn about contributing" target="_blank">
    <img alt="Contributing" src="https://img.shields.io/badge/Contributing-Guide-0074D9?logo=github-sponsors&logoColor=white&style=for-the-badge" />
  </a>
  <a href="https://app.slack.com/client/T01ABCG4NK1/C01NN74H0LW/details/" title="Chat with us on Slack" target="_blank">
    <img alt="Slack" src="https://img.shields.io/badge/Slack-Chat-e01e5a?logo=slack&logoColor=white&style=for-the-badge" />
  </a>
  <a href="https://github.com/ProfessorManhattan/docker-devcontainer" title="GitHub mirror" target="_blank">
    <img alt="GitHub" src="https://img.shields.io/badge/Mirror-GitHub-333333?logo=github&style=for-the-badge" />
  </a>
  <a href="https://gitlab.com/megabyte-labs/docker/software/devcontainer" title="GitLab repository" target="_blank">
    <img alt="GitLab" src="https://img.shields.io/badge/Repo-GitLab-fc6d26?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQMAAABJtOi3AAAABlBMVEUAAAD///+l2Z/dAAAAAXRSTlMAQObYZgAAAHJJREFUCNdNxKENwzAQQNEfWU1ZPUF1cxR5lYxQqQMkLEsUdIxCM7PMkMgLGB6wopxkYvAeI0xdHkqXgCLL0Beiqy2CmUIdeYs+WioqVF9C6/RlZvblRNZD8etRuKe843KKkBPw2azX13r+rdvPctEaFi4NVzAN2FhJMQAAAABJRU5ErkJggg==&style=for-the-badge" />
  </a>
</div>
<br/>
<div align="center">
  <a title="Version: 0.0.1" href="https://github.com/ProfessorManhattan/docker-devcontainer" target="_blank">
    <img alt="Version: 0.0.1" src="https://img.shields.io/badge/version-0.0.1-blue.svg?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQMAAABJtOi3AAAABlBMVEUAAAD///+l2Z/dAAAAAXRSTlMAQObYZgAAACNJREFUCNdjIACY//+BEp9hhM3hAzYQwoBIAqEDYQrCZLwAAGlFKxU1nF9cAAAAAElFTkSuQmCC&cacheSeconds=2592000&style=flat-square" />
  </a>
  <a title="GitLab build status" href="https://gitlab.com/megabyte-labs/docker/software/devcontainer/-/commits/master" target="_blank">
    <img alt="Build status" src="https://img.shields.io/gitlab/pipeline-status/megabyte-labs/docker/software/devcontainer?branch=master&label=build&logo=gitlab&logoColor=white&style=flat-square">
  </a>
  <a title="DockerHub image size" href="https://hub.docker.com/repository/docker/megabytelabs/devcontainer" target="_blank">
    <img alt="Image size" src="https://img.shields.io/docker/image-size/megabytelabs/devcontainer?logo=docker&sort=date&logoColor=white&style=flat-square">
  </a>
  <a title="DockerHub pulls" href="https://hub.docker.com/repository/docker/megabytelabs/devcontainer" target="_blank">
    <img alt="Pulls" src="https://img.shields.io/docker/pulls/megabytelabs/devcontainer?logo=docker&logoColor=white&style=flat-square">
  </a>
  <a title="DockerHub stars" href="https://hub.docker.com/repository/docker/megabytelabs/devcontainer" target="_blank">
    <img alt="Stars" src="https://img.shields.io/docker/stars/megabytelabs/devcontainer?logo=docker&logoColor=white&style=flat-square">
  </a>
  <a title="Documentation" href="https://megabyte.space/docs/docker" target="_blank">
    <img alt="Documentation" src="https://img.shields.io/badge/documentation-yes-brightgreen.svg?logo=readthedocs&logoColor=white&style=flat-square" />
  </a>
  <a title="License: MIT" href="https://github.com/ProfessorManhattan/docker-devcontainer/blob/master/LICENSE" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-yellow.svg?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgAQMAAABJtOi3AAAABlBMVEUAAAD///+l2Z/dAAAAAXRSTlMAQObYZgAAAHpJREFUCNdjYOD/wMDAUP+PgYHxhzwDA/MB5gMM7AwMDxj4GBgKGGQYGCyAEEgbMDDwAAWAwmk8958xpIOI5zKH2RmOyhxmZjguAiKmgIgtQOIYmFgCIp4AlaQ9OczGkJYCJEAGgI0CGwo2HmwR2Eqw5SBnNIAdBHYaAJb6KLM15W/CAAAAAElFTkSuQmCC&style=flat-square" />
  </a>
</div>

> </br><h4 align="center">**The Docker-based, DevContainer development environment for multi-language projects**</h4></br>

<a href="#table-of-contents" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
  - [Development Requirements](#development-requirements)
- [Example Usage](#example-usage)
  - [Integrating with GitLab CI](#integrating-with-gitlab-ci)
  - [Building the Docker Container](#building-the-docker-container)
  - [Building a Slim Container](#building-a-slim-container)
  - [Build Tools](#build-tools)

<a href="#overview" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Overview

Utilizing Continuous Integration (CI) tools can improve developer efficiency drastically. They allow you to do things like scan new code for possible errors and automatically deploy new software.

This repository is home to the build instructions for a Docker container that is just one piece to the CI puzzle. Nearly all of [our CI pipeline Docker projects](https://gitlab.com/megabyte-labs/dockerfile/ci-pipeline) serve a single purpose.

Instead of using one of the countless pretty_name public Docker images available, we create it in-house so we know exactly what code is present in the container. We also ensure that all of our CI pipeline images are as small as possible so that our CI environment can download and run the specific task as quickly as possible. Using this repository as a base, you too can easily create your own in-house CI pipeline container image.

At first glance, you might notice that there are many files in this repository. Nearly all the files and folders that have a period prepended to them are development configurations. The tools that these files and folders configure are meant to make development easier and faster. They are also meant to improve team development by forcing developers to follow strict standards so that the same design patterns are used across all of our repositories.

<a href="#requirements" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Requirements

- **[Docker](https://gitlab.com/megabyte-labs/ansible-roles/docker)**

### Development Requirements

- **[DockerSlim](repository.project.dockerslim)** - Used for generating compact, secure images
- **[jq](repository.project.jq)** - Used for interacting with JSON
- **[Node.js](repository.project.node)** (_>=14.18_) - Utilized to add development features like a pre-commit hook and maintenance tasks
- _Many more_ requirements that are _dynamically installed_ as they are needed by our `Taskfile.yml` via our custom [go-task/task](https://github.com/go-task/task) fork named **[Bodega](https://github.com/ProfessorManhattan/Bodega)**

If you choose to utilize the development tools provided by this project then at some point you will have to run `bash start.sh` (or `npm i` which calls `bash start.sh` after it is done). The `start.sh` script will attempt to automatically install any requirements (without sudo) that are not already present on your build system to the user's `~/.local/bin` folder. The `start.sh` script also takes care of other tasks such as generating the documentation by calling tasks defined in the `Taskfile.yml`. For more details on how the optional requirements are used and set up, check out the [CONTRIBUTING.md](https://gitlab.com/megabyte-labs/docker/software/devcontainer/-/blob/master/docs/CONTRIBUTING.md) guide.

When you are ready to start development, run `task --menu` to open an interactive dialog that will help you understand what build commands we have already engineered for you.

<a href="#example-usage" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Example Usage

There are several different ways you can use the Docker container provided by this project. For starters, you can test the feature out locally by running:

```shell
docker run -v ${PWD}:/work -w /work megabytelabs/devcontainer:preferred_tag docker_command
```

This allows you to run pretty_name without installing it locally. This could be good for security since the application is within a container and also keeps your file system clean.

You can also add a bash alias to your `~/.bashrc` file so that you can run the pretty_name command at any time. To do this, add the following snippet to your `~/.bashrc` file (or `~/.bash_profile` if you are on macOS):

```shell
docker_command_alias() {
    docker run -v ${PWD}:/work -w /work megabytelabs/devcontainer:preferred_tag "$@"
}
```

_Note: Some CLI tools run without any arguments passed in. For example, the CLI tool `ansible-lint` runs by simply entering `ansible-lint` in the terminal. Our Docker images default command is to show the version so to get around this quirk you would run `ansible-lint .`._

### Integrating with GitLab CI

The main purpose of this project is to build a Docker container that can be used in CI pipelines. For example, if you want to incorporate this CI pipeline tool into GitLab CI project then your first step would be to create a `.gitlab-ci.yml` file in the root of your repository that is hosted by GitLab. Your `.gitlab-ci.yml` file should look something like this:

```yaml
---
stages:
  - lint

include:
  - remote: https://gitlab.com/megabyte-space/gitlab-ci-templates/-/raw/master/devcontainer.gitlab-ci.yml
```

That is it! pretty_name will now run anytime you commit code (that matches the parameters laid out in the `remote:` file above). Ideally, for production, you should copy the source code from the `remote:` link above to another location and update the `remote:` link to the file's new location. That way, you do not have to worry about any changes that are made to the `remote:` file by our team.

### Building the Docker Container

You may have a use case that requires some modifications to our Docker image. After you make changes to the Dockerfile, you can upload your custom container to [Docker Hub](website.dockerhub) using the following code:

```shell
export DOCKERHUB_USERNAME=Your_DockerHub_Username_Here
export DOCKERHUB_PASSWORD=Your_DockerHub_Password_Here
docker login -u "$DOCKERHUB_USERNAME" -p "$DOCKERHUB_PASSWORD" docker.io
docker build --pull -t "$DOCKERHUB_USERNAME/devcontainer:latest" .
docker push "$DOCKERHUB_USERNAME/devcontainer:latest"
```

After setting your DockerHub username and password, the commands above will build the Docker image and upload it to [Docker Hub](https://hub.docker.com/) where it will be publicly accessible. You can see this logic being implemented as a [GitLab CI task here](repository.link.dockerhub_ci_task). This GitLab CI task works in conjunction with the `.gitlab-ci.yml` file in the root of this repository.

### Building a Slim Container

Some of our repositories support creating a slim build via [DockerSlim](https://gitlab.com/megabyte-labs/ansible-roles/dockerslim). According to [DockerSlim's GitHub page](https://github.com/docker-slim/docker-slim), slimming down containers reduces the final image size and improves the security of the image by reducing the attack surface. It makes sense to create a slim build for anything that supports it, including Alpine images. On their GitHub page, they report that some images can be reduced in size by up to 448.76X. This means that if your image is naturally **700MB** then it **can be reduced to 1.56MB**! It works by removing everything that is unnecessary in the container image.

As a convenience feature, we include a command defined in `package.json` that should build the slim image. Just run `task docker:build` after running `npm i` (or `bash start.sh` if you do not have `Node.js` installed) in the root of this repository to build both the `latest` and `slim` builds.

To build and publish a `slim` Dockerfile to Docker Hub manually, you can use the following as a starting point:

```shell
export DOCKERHUB_USERNAME=Your_DockerHub_Username_Here
export DOCKERHUB_PASSWORD=Your_DockerHub_Password_Here
docker login -u "$DOCKERHUB_USERNAME" -p "$DOCKERHUB_PASSWORD" docker.io
docker build -t "$DOCKERHUB_USERNAME/devcontainer:latest" .
docker-slim build --tag $DOCKERHUB_USERNAME/devcontainer:slim {{#if (eq (typeOf dockerSlimCommand) "string")}}dockerSlimCommand}}{{/if{{#if (not (eq (typeOf dockerSlimCommand) "string"))}}dockerSlimCommand[slug]}}{{/if $DOCKERHUB_USERNAME/devcontainer:latest
docker push "$DOCKERHUB_USERNAME/devcontainer:slim"
```

It may be possible to modify the DockerSlim command above to fix an issue or reduce the footprint even more than our command. You can modify the slim build command inline in the `package.json` file under `blueprint.dockerSlimCommand`. Some of our repositories have multiple build targets in the `Dockerfile` so those repositories will have multiple `dockerSlimCommands`.

If you come up with an improvement, please do [open a pull request](repository.group.dockerCodeClimate/devcontainer/-/issues/new). And again, make sure you replace `DOCKERHUB_USERNAME` and `DOCKERHUB_PASSWORD` in the snippet above with your Docker Hub username and password. The commands in the snippet above will build the slim Docker image and upload it to [Docker Hub](https://hub.docker.com/) where it will be publicly accessible.

### Build Tools

You might notice that we have a lot of extra files considering that this repository basically boils down to a single Dockerfile. These extra files are meant to make team development easier, predictable, and enjoyable. If you have a recent version of [Node.js](repository.project.node) installed, you can get started using our build tools by running `npm i` (or by running `bash start.sh` if you do not currently have Node.js installed) in the root of this repository. After that, you can run `task --list` to see a list of the available development features. Alternatively, you can run `task --menu` to view an interactive menu that will guide you through the development process.

_Note:_ We use a custom-built version of [go-task/task](https://github.com/go-task/task) so if you already have it installed then you should either replace it with our version or use a different bin name for `task`.

For more details, check out the [CONTRIBUTING.md](https://gitlab.com/megabyte-labs/docker/software/devcontainer/-/blob/master/CONTRIBUTING.md) file.

{{ load:.config/docs/readme/contributing-details.md }}
{{ load:.config/docs/readme/license.md }}
