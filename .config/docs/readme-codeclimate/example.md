## Examples

There are several different ways you can use the Docker container provided by this project. For starters, you can test the tool out locally by running:

```shell
docker run -it -v ${PWD}:/work -w /work --rm megabytelabs/{{ slug }}:latest {{ dockerExampleCommand }}
```

This allows you to run {{ name }} without installing it locally. It also removes the image from your system when you are done. This could be good for security since the application is within a container and also keeps your file system clean.

You can also add a bash alias to your `~/.bashrc` file so that you can run the {{ name }} command at any time. To do this, add the following snippet to your `~/.profile` file (or equivalent):

```shell
{{ slug }}() {
    docker run -it -v ${PWD}:/work -w /work --rm megabytelabs/{{ slug }}:latest "$@"
}
```

_Note: Some CLI tools run without any arguments passed in. For example, the CLI tool `ansible-lint` runs by simply entering `ansible-lint` in the terminal. Our Docker images default command is to show the version so to get around this quirk you would run `ansible-lint .`._

### Integrating with GitLab CI

The main purpose of this project is to build a Docker container that can be used in CI pipelines and during GitLab CI CodeClimate analysis.

#### CodeClimate GitLab CI Example

If you are interested in improving the GitLab web UI for your merge requests, then you can take a peek at our [GitLab CI configuration for CodeClimate](https://gitlab.com/megabyte-labs/gitlab-ci/-/raw/master/lint/codeclimate.gitlab-ci.yml). It has to run in a single CI stage that includes all the linters you want to report on because GitLab CI only accepts one CodeClimate report artifact.

#### CodeClimate CLI Walkthrough

If you want to incorporate CodeClimate into your project, you need to ensure that you have a `.codeclimate.yml` properly setup in the root of your project. At the very minimum, the file might look something like this:

```yml
---
engines:
  {{slug}}:
    enabled: true
exclude_paths:
  - 'node_modules/**'
```

Also, before you run the CodeClimate CLI, you need to ensure that this project's CodeClimate image is pulled to your local cache and properly tagged for CodeClimate. You can accomplish this by running:

```shell
docker pull megabytelabs/codeclimate-{{slug}}:latest
docker tag megabytelabs/codeclimate-{{slug}}:latest codeclimate/codeclimate-{{slug}}:latest
```

After that, you need to invoke the CodeClimate CLI by passing the `--dev` parameter. This may seem hacky but it is the only way of using CodeClimate engines that are not officially hosted in the `codeclimate` namespace on DockerHub. Your CLI command might look something like this:

```shell
brew install codeclimate/formulae/codeclimate
codeclimate analyze --dev
```

Or if you want to see an HTML report:

```shell
brew install codeclimate/formulae/codeclimate
codeclimate analyze --dev  -f html > codeclimate-report.html
```

#### Standalone Integration

If you want to incorporate this CI pipeline tool into GitLab CI project without CodeClimate integration then your first step would be to create a `.gitlab-ci.yml` file in the root of your GitLab repository. Your `.gitlab-ci.yml` file should look something like this:

```yaml
---
stages:
  - lint

include:
  - remote: https://gitlab.com/megabyte-labs/gitlab-ci/-/raw/master/lint/{{ slug }}.gitlab-ci.yml
```

That is it! {{ name }} will now run anytime you commit code (that matches the parameters laid out in the `remote:` file above). Ideally, for production, you should copy the source code from the `remote:` link above to another location and update the `remote:` link to the file's new location. That way, you do not have to worry about any changes that are made to the `remote:` file by our team.
