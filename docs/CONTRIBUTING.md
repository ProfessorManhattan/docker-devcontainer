<!-- ⚠️ This README has been generated from the file(s) ".config/docs/blueprint-contributing.md" ⚠️--><div align="center">
  <center><h1 align="center">Contributing Guide</h1></center>
</div>

First of all, thanks for visiting this page 😊 ❤️ ! We are _stoked_ that you may be considering contributing to this project. You should read this guide if you are considering creating a pull request or plan to modify the code for your own purposes.

<a href="#table-of-contents" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Overview](#overview)
- [Style Guide](#style-guide)
- [Philosophy](#philosophy)
  - [Choosing a Base Image](#choosing-a-base-image)
- [Requirements](#requirements)
  - [Other Requirements](#other-requirements)
- [Getting Started](#getting-started)
  - [Creating DockerSlim Builds](#creating-dockerslim-builds)
    - [How to Determine Which Paths to Include](#how-to-determine-which-paths-to-include)
    - [Determining Binary Dependencies](#determining-binary-dependencies)
  - [Using a `paths.txt` File](#using-a-pathstxt-file)
- [Testing](#testing)
  - [Testing DockerSlim Builds](#testing-dockerslim-builds)
  - [Testing Web Apps](#testing-web-apps)
- [Linting](#linting)
- [Pull Requests](#pull-requests)
  - [Pre-Commit Hook](#pre-commit-hook)
- [Style Guides](#style-guides)
  - [Recommended Style Guides](#recommended-style-guides)
  - [Strict Linting](#strict-linting)

<a href="#code-of-conduct" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Code of Conduct

This project and everyone participating in it is governed by the [Code of Conduct](https://github.com/megabyte-labs/docker-devcontainer/blob/master/docs/CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to [help@megabyte.space](mailto:help@megabyte.space).

<a href="#overview" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Overview

All our Dockerfiles are created for specific tasks. In many cases, this allows us to reduce the size of the Dockerfiles by removing unnecessary files and performing other optimizations. [Our Dockerfiles](https://gitlab.com/megabyte-labs/docker) are broken down into the following categories:

- **[Ansible Molecule](repository.group.dockerfile_ansible_molecule)** - Dockerfile projects used to generate pre-built Docker containers that are intended for use by Ansible Molecule
- **[Apps](repository.group.dockerfile_apps)** - Full-fledged web applications
- \*\*[CodeClimate](https://gitlab.com/megabyte-labs/docker/codeclimate) - CodeClimate engines
- **[CI Pipeline](repository.group.dockerfile_ci)** - Projects that include tools used during deployments such as linters and auto-formatters
- **[Software](repository.group.dockerfile_software)** - Docker containers that are meant to replace software that is traditionally installed directly on hosts

<a href="#style-guide" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Style Guide

In addition to reading through this guide, you should also read our [Docker Style Guide](https://gitlab.com/megabyte-labs/templates/docker) template repository which outlines implementation methods that allow us to manage a large number of Dockerfile projects using automated practices.

<a href="#philosophy" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Philosophy

When you are working on one of our Dockerfile projects, try asking yourself, "How can this be improved?" By asking yourself that question, you might decide to take the project a step further by opening a merge request that:

- Reduces the size of the Docker container by converting it from a Ubuntu image to an Alpine image
- Improves the security and reduces the size of the Docker container by including a [DockerSlim](website.dockerslim_github_page) configuration
- Lints the Dockerfile to conform with standards set in place by [Haskell Dockerfile Linter](website.hadolint_github_page)

All of these improvements would be greatly appreciated by us and our community. After all, we want all of our Dockerfiles to be the best at what they do.

### Choosing a Base Image

- Whenever possible, use Alpine as the base image. It has a very small footprint so the container image downloads faster.
- Whenever possible, choose an image with a `slim` tag. This is beneficial when, say, Alpine is incompatible with the requirements and you must use something besides an Alpine image.
- Avoid using the latest tag (e.g. `node:latest`). Instead use specific versions like `node:15.4.2`. This makes debugging production issues easier.
- When choosing a base image version, always choose the most recent update. There are often known vulnerabilities with older versions.
- If all else fails, feel free to use other base images as long as they come from a trusted provider (i.e. using `ubuntu:latest` is fine but using `bobmighthackme:latest` is not).

<a href="#requirements" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Requirements

Before getting started with development, you should ensure that the following requirements are present on your system:

- **[Docker](repository.project.docker)**

Although most requirements will automatically be installed when you use our build commands, Docker should be installed ahead of time because it usually requires a reboot.

Getting started should be fairly straight-forward. All of our projects should include a file named `start.sh`. Simply run, `bash start.sh` to run a basic update on the repository. This should install most (if not all of the requirements).

### Other Requirements

Here is a list of a few of the dependencies that will be automatically installed when you use the commands defined in our `Taskfile.yml` files

- [DockerSlim](repository.project.dockerslim) - Tool used to generate compact, secure images. Our system will automatically attempt to build both a regular image and a DockerSlim image when you adhere to the guidelines laid out in our [Docker Style Guide](https://gitlab.com/megabyte-labs/templates/docker). DockerSlim allows us to ship containers that can be significantly smaller in size (sometimes up to 90% smaller).
- [container-structure-test](https://github.com/GoogleContainerTools/container-structure-test) - A Google product that allows you to define and run tests against Dockerfile builds. It is used to perform basic tests like making sure that a container can start without an error.
- [GitLab Runner](https://docs.gitlab.com/runner/) - Tool that allows for the simulation and execution of GitLab CI workflows. It can run tests / scenarios defined in the `.gitlab-ci.yml` file.

Having an understanding of these tools is key to adhereing to our [Docker Style Guide](https://gitlab.com/megabyte-labs/templates/docker) and ensuring that each project can integrate into our automation pipelines.

<a href="#getting-started" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Getting Started

To get started when developing one of [our Dockerfile projects](https://gitlab.com/megabyte-labs/docker) (after you have installed [Docker](repository.project.docker)), the first command you need to run in the root of the project is:

```shell
bash start.sh
```

This command will ensure the dependencies are installed and update the project to ensure upstream changes are integrated into the project. You should run it anytime you step away from a project (just in case changes were made to the upstream files).

### Creating DockerSlim Builds

Whenever possible, a DockerSlim build should be provided and tagged as `:slim`. DockerSlim provides many configuration options so please check out the [DockerSlim documentation](website.dockerslim_github_page) to get a thorough understanding of it and what it is capable of. When you have formulated _and fully tested_ the proper DockerSlim configuration, you will need to add to the `blueprint` section of the `package.json` file. **More details on this are in our [Docker Style Guide](https://gitlab.com/megabyte-labs/templates/docker).**

#### How to Determine Which Paths to Include

In most cases, the DockerSlim configuration in `package.json` will require the use of `--include-path`. If you were creating a slim build that included `jq`, for instance, then you would need to instruct DockerSlim to hold onto the `jq` binary. You can determine where the binary is stored on the target machine by running:

```bash
npm run shell
which jq
```

You would then need to include the path that the command above displays in the `dockerSlimCommand` key of `blueprint` section in `package.json`. The `package.json` might look something like this:

```json
{
  ...
  "blueprint": {
    ...
    "dockerSlimCommand": "--http-probe=false --exec 'npm install' --include-path '/usr/bin/jq'"
  }
}
```

#### Determining Binary Dependencies

**Note: The method described in this section should not usually be required if you use the `--include-bin` flag (e.g. `--include-bin /usr/bin/jq`). The `--include-bin` option will automatically perform the steps outlined below.**

If you tried to use the `dockerSlimCommand` above, you might notice that it is incomplete. That is because `jq` relies on some libraries that are not bundled into the executable. You can determine the libraries you need to include by using the `ldd` command like this:

```bash
npm run shell
ldd $(which jq)
```

The command above would output something like this:

```shell
	/lib/ld-musl-x86_64.so.1 (0x7fa35376c000)
	libonig.so.5 => /usr/lib/libonig.so.5 (0x7fa35369e000)
	libc.musl-x86_64.so.1 => /lib/ld-musl-x86_64.so.1 (0x7fa35376c000)
```

Using the information above, you can see two unique libraries being used. You should then check out the slim build to see which of the two libraries is missing. This can be done by running:

```bash
echo "***Base image libraries for jq***"
npm run shell
cd /usr/lib
ls | grep libonig.so.5
cd /lib
ls | grep ld-musl-x86_64.so.1
exit
echo "***Slim image libraries for jq***"
npm run shell:slim
cd /usr/lib
ls | grep libonig.so.5
cd /lib
ls | grep ld-musl-x86_64.so.1
exit
```

You should then compare the output from the base image with the slim image. After you compare the two, in this case, you will see that the slim build is missing `/usr/lib/libonig.so.5` and `/usr/lib/libonig.so.5.1.0`. So, finally, you can complete the necessary configuration in `package.json` by including the paths to the missing libraries:

```json
{
  ...
  "blueprint": {
  ...
    "dockerSlimCommand": "--http-probe=false --exec 'npm install' --include-path '/usr/bin/jq' --include-path '/usr/lib/libonig.so.5' --include-path '/usr/lib/libonig.so.5.1.0'"
  }
}
```

### Using a `paths.txt` File

In the above example, we use `--include-path` to specify each file we want to include in the optimized Docker image. If you are ever including more than a couple includes, you should instead create a line return seperated list of paths to preserve in a file named `local/paths.txt`. You can then include the paths in the `dockerSlimCommand` by using utilizing `--preserve-path-file`. The `dockerSlimCommand` above would then look like this if you create the `local/paths.txt` file:

```json
{
  ...
  "dockerSlimCommand": "--http-probe=false --exec 'npm install' --preserve-path-file 'local/paths.txt'"
}
```

<a href="#testing" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Testing

Testing is an **extremely important** part of contributing to this project. Before opening a merge request, **you must test all common use cases of the Docker image**. The following chart details the types of tests, when they are required, and provides examples:

| Test Type                                                   | Test Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Required                                                | Example                                                                                                                   |
| ----------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **Docker.test.yml ContainerStructureTest**                  | If the project has a `Docker.test.yml` file defined, then a [ContainerStructureTest](https://github.com/GoogleContainerTools/container-structure-test) will be run on both the regular and slim build (if there is one). If there are not multiple build targets defined in the `Dockerfile`, then you should use this type of test (by naming the test `Docker.test.yml`). Ideally, you should leverage some sample project files which should be stored in a folder in the `test/` directory.             | Required when the Dockerfile has 1 build target         | [Example `Docker.test.yml`](https://gitlab.com/megabyte-labs/docker/software/devcontainer/-/blob/master/Docker.test.yml)  |
| **Multiple Docker.target.test.yml ContainerStructureTests** | If the project has multiple build targets defined in the `Dockerfile`, then multiple ContainerStructureTests are required. Each one should be named `Docker.target.test.yml` where target is replaced with the build target name defined in the `Dockerfile`. This will also test both the regular and slim builds. Similar to the previous test type, it is preferrable to make use of test files stored in a directory in the `test/` directory.                                                          | Required when the Dockerfile has multiple build targets | [Example Repository](https://gitlab.com/megabyte-labs/docker/codeclimate/eslint)                                          |
| **`test-output` Tests**                                     | For each folder in the `test-output` directory, both the regular and slim build will be run in the directory. The container is run by running `docker run -it image:tag .`. If the console output of the regular build does not match the output of the slim build, then this test will fail. ContainerStructureTests are preferrable but this test type is provided for cases where ContainerStructureTests might not suite your needs.                                                                    | _Optional_                                              | _Coming soon.. maybe.._                                                                                                   |
| **CodeClimate CLI Test**                                    | This test is unique to [CodeClimate Docker projects](https://gitlab.com/megabyte-labs/docker/codeclimate). For each folder in the `test/` directory that begins with `codeclimate`, the [CodeClimate CLI](https://docs.codeclimate.com/docs/command-line-interface) will run with options specified in the `lint:codeclimate` task. Before running the CodeClimate CLI, our `slim` custom versions of the CodeClimate engines will be pulled from DockerHub and then tagged as `codeclimate/engine:latest`. | Required for CodeClimate engine projects                | [Example `codeclimate` folder](https://gitlab.com/megabyte-labs/docker/codeclimate/eslint/-/tree/master/test/codeclimate) |
| **GitLab Runner Test**                                      | This test will ensure that the container can be run on GitLab CI by using a local instance of a [GitLab Runner](https://docs.gitlab.com/runner/). The GitLab Runner test simulates GitLab CI pipeline steps by running each stage defined in `.gitlab-ci.yml` that starts with `integration:`.                                                                                                                                                                                                              | Required for any project that might be run on GitLab CI | [Example `.gitlab-ci.yml`](https://gitlab.com/megabyte-labs/docker/codeclimate/eslint/-/blob/master/.gitlab-ci.yml)       |

_Note: If you are interested in testing GitHub Actions, then you might be interested in [act](https://github.com/nektos/act). This is not integrated into our automated test flow but you can install it by running `task install:software:act`._

### Testing DockerSlim Builds

It is especially important to test DockerSlim builds. DockerSlim works by removing all the components in a container's operating system that it thinks are unnecessary. This can easily break things.

For example, if you are testing a DockerSlim build that packages [ansible-lint](repository.project.ansiblelint) into a slim container, you might be tempted to simply test it by running `docker exec -it MySlimAnsibleLint ansible-lint`. This will ensure that the ansible-lint command can be accessed but that is not enough. You should also test it by passing in files as a volume and command line arguments. You can see an [example of this in the Ansible Lint repository](repository.project.ansiblelint).

It is **important** to test all common use cases. Some people might be using the `ansible-lint` container in CI where the files are injected into the Docker container and some people might be using an inline command to directly access ansible-lint from the host.

### Testing Web Apps

When testing Docker-based web applications, ensure that after you destroy the container along with its volumes you can bring the Docker container back up to its previous state using volumes and file mounts. This allows users to periodically update the Docker container while having their settings persist. This requirement is also for disaster recovery.

<a href="#linting" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Linting

We utilize several different linters to ensure that all our Dockerfile projects use similar design patterns. Linting sometimes even helps spot errors as well. The most important linter for Dockerfile projects is called [Haskell Dockerfile Linter](website.hadolint_github_page) (or hadolint). We also use many other linting tools depending on the file type. Simply run `git commit` to invoke the pre-commit hook (after running `bash start.sh` ahead of time) to automatically lint the changed files in the project.

Some of the linters are also baked into the CI pipeline. The pipeline will trigger whenever you post a commit to a branch. All of these pipeline tasks must pass in order for merge requests to be accepted. You can check the status of recently triggered pipelines for this project by going to the [CI/CD pipeline page](https://gitlab.com/megabyte-labs/docker/software/devcontainer/-/pipelines).

<a href="#pull-requests" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Pull Requests

All pull requests should be associated with issues. You can find the [issues board on GitLab](https://gitlab.com/megabyte-labs/docker/software/devcontainer/-/issues). The pull requests should be made to [the GitLab repository](https://gitlab.com/megabyte-labs/docker/software/devcontainer) instead of the [GitHub repository](ProfessorManhattan/docker-devcontainer). This is because we use GitLab as our primary repository and mirror the changes to GitHub for the community.

### Pre-Commit Hook

Even if you decide not to use `npm run commit`, you will see that `git commit` behaves differently because there is a pre-commit hook that installs automatically after you run `npm i` (or `bash start.sh`). This pre-commit hook is there to test your code before committing and help you become a better coder. If you need to bypass the pre-commit hook, then you may add the `--no-verify` tag at the end of your `git commit` command and `HUSKY=0` at the beginning (e.g. `HUSKY=0 git commit -m "Commit" --no-verify`).

<a href="#style-guides" style="width:100%"><img style="width:100%" src="https://gitlab.com/megabyte-labs/assets/-/raw/master/png/aqua-divider.png" /></a>

## Style Guides

All code projects have their own style. Coding style will vary from coder to coder. Although we do not have a strict style guide for each project, we do require that you be well-versed in what coding style is most acceptable and _best_. To do this, you should read through style guides that are made available by organizations that have put a lot of effort into studying the reason for coding one way or another.

### Recommended Style Guides

Style guides are generally written for a specific language but a great place to start learning about the best coding practices is on [Google Style Guides](https://google.github.io/styleguide/). Follow the link and you will see style guides for most popular languages. We also recommend that you look through the following style guides, depending on what language you are coding with:

- [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)
- [Angular Style Guide](https://angular.io/guide/styleguide)
- [Effective Go](https://go.dev/doc/effective_go)
- [PEP 8 Python Style Guide](https://www.python.org/dev/peps/pep-0008/)
- [Git Style Guide](https://github.com/agis/git-style-guide)

For more informative links, refer to the [GitHub Awesome Guidelines List](https://github.com/Kristories/awesome-guidelines).

### Strict Linting

One way we enforce code style is by including the best standard linters into our projects. We normally keep the settings pretty strict. Although it may seem pointless and annoying at first, these linters will make you a better coder since you will learn to adapt your style to the style of the group of people who spent countless hours creating the linter in the first place.
