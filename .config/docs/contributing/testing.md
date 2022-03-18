## Testing

Testing is an **extremely important** part of contributing to this project. Before opening a merge request, **you must test all common use cases of the Docker image**. The following chart details the types of tests, when they are required, and provides examples:

{{docker_tests}}

*Note: If you are interested in testing GitHub Actions, then you might be interested in [act](https://github.com/nektos/act). This is not integrated into our automated test flow but you can install it by running `task install:software:act`.*

### Testing DockerSlim Builds

It is especially important to test DockerSlim builds. DockerSlim works by removing all the components in a container's operating system that it thinks are unnecessary. This can easily break things.

For example, if you are testing a DockerSlim build that packages [ansible-lint]({{ repository.project.ansiblelint }}) into a slim container, you might be tempted to simply test it by running `docker exec -it MySlimAnsibleLint ansible-lint`. This will ensure that the ansible-lint command can be accessed but that is not enough. You should also test it by passing in files as a volume and command line arguments. You can see an [example of this in the Ansible Lint repository]({{ repository.project.ansiblelint }}).

It is **important** to test all common use cases. Some people might be using the `ansible-lint` container in CI where the files are injected into the Docker container and some people might be using an inline command to directly access ansible-lint from the host.

### Testing Web Apps

When testing Docker-based web applications, ensure that after you destroy the container along with its volumes you can bring the Docker container back up to its previous state using volumes and file mounts. This allows users to periodically update the Docker container while having their settings persist. This requirement is also for disaster recovery.
