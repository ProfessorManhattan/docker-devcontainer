## Overview

{{overview}}

### Standalone

If you are interested in using the tool and have no need for CodeClimate integration, you can get the `latest`, `slim`, and versioned images without CodeClimate-related code by removing the `codeclimate-` string from the image name. For example, if the image is named `megabytelabs/codeclimate-{{ slug }}`, then you can get the same image without CodeClimate-related code by using the `megabytelabs/{{ slug }}` image. For a full listing of images to choose from, check out the [DockerHub page for this project](https://hub.docker.com/r/megabytelabs/{{ slug }}).

_Note:_ The DockerHub page for the CodeClimate engine version of this project is located on the aforementioned DockerHub page and also on a [separate DockerHub page](https://hub.docker.com/r/megabytelabs/codeclimate-{{ slug }}) prefixed with `codeclimate-`.

### Slim Build

All of our CodeClimate engine projects include two variants. One is the regular build that is created using Docker and the `Dockerfile` that is in the root of this project. The other build is a `slim` build that is built via DockerSlim. If you are looking for stability and want to take advantage of the `slim` build, then you should specify an exact version when referencing the image (e.g. `megabytelabs/codeclimate-package:5.4.0-slim` instead of `megabytelabs/codeclimate-package:slim`).

### Versioning

Whenever possible, we tag our Docker image versions with the corresponding version of the software that the Docker image is used for. For instance, if you are using the ESLint CodeClimate image, then the `megabytelabs/codeclimate-eslint:5.4.0` image means that it likely includes ESLint at version `5.4.0`. There may be some exceptions but this is what we strive for.

### Testing

Multiple methods of testing are used to ensure both the `latest` and `slim` build function properly. The `Dockerfile-test.yml` file in the root of the repository is a [container-structure-test](https://github.com/GoogleContainerTools/container-structure-test) configuration that ensures that each container is working properly. On top of that, we also run commands on sample projects stored in `test/compare/` to ensure that the output from the `latest` image matches the output from the `slim` image. In some other scenarios, we also include unit tests for custom code written for the CodeClimate engine.
