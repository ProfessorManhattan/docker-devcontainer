## Requirements

- **[Docker](https://gitlab.com/megabyte-labs/ansible-roles/docker)**

### Development Requirements

- **[DockerSlim]({{ repository.project.dockerslim }})** - Used for generating compact, secure images
- **[jq]({{ repository.project.jq }})** - Used for interacting with JSON
- **[Node.js]({{ repository.project.node }})** (_>=14.18_) - Utilized to add development features like a pre-commit hook and maintenance tasks
- *Many more* requirements that are *dynamically installed* as they are needed by our `Taskfile.yml` via our custom [go-task/task](https://github.com/go-task/task) fork named **[Bodega](https://github.com/ProfessorManhattan/Bodega)**

If you choose to utilize the development tools provided by this project then at some point you will have to run `bash start.sh` (or `npm i` which calls `bash start.sh` after it is done). The `start.sh` script will attempt to automatically install any requirements (without sudo) that are not already present on your build system to the user's `~/.local/bin` folder. The `start.sh` script also takes care of other tasks such as generating the documentation by calling tasks defined in the `Taskfile.yml`. For more details on how the optional requirements are used and set up, check out the [CONTRIBUTING.md]({{ repository.group.dockerfile }}/{{ subgroup }}/{{ slug }}/-/blob/master/docs/CONTRIBUTING.md) guide.

When you are ready to start development, run `task --menu` to open an interactive dialog that will help you understand what build commands we have already engineered for you.
