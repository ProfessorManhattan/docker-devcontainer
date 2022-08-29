## Requirements

Before getting started with development, you should ensure that the following requirements are present on your system:

- **[Docker]({{ repository.project.docker }})**

Although most requirements will automatically be installed when you use our build commands, Docker should be installed ahead of time because it usually requires a reboot.

Getting started should be fairly straight-forward. All of our projects should include a file named `start.sh`. Simply run, `bash start.sh` to run a basic update on the repository. This should install most (if not all of the requirements).

### Other Requirements

Here is a list of a few of the dependencies that will be automatically installed when you use the commands defined in our `Taskfile.yml` files

- [DockerSlim]({{ repository.project.dockerslim }}) - Tool used to generate compact, secure images. Our system will automatically attempt to build both a regular image and a DockerSlim image when you adhere to the guidelines laid out in our [Docker Style Guide](https://gitlab.com/megabyte-labs/templates/docker). DockerSlim allows us to ship containers that can be significantly smaller in size (sometimes up to 90% smaller).
- [container-structure-test](https://github.com/GoogleContainerTools/container-structure-test) - A Google product that allows you to define and run tests against Dockerfile builds. It is used to perform basic tests like making sure that a container can start without an error.
- [GitLab Runner](https://docs.gitlab.com/runner/) - Tool that allows for the simulation and execution of GitLab CI workflows. It can run tests / scenarios defined in the `.gitlab-ci.yml` file.

Having an understanding of these tools is key to adhereing to our [Docker Style Guide](https://gitlab.com/megabyte-labs/templates/docker) and ensuring that each project can integrate into our automation pipelines.
