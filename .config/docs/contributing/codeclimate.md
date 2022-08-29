## Basics of CodeClimate

CodeClimate is an eco-system of plugins that inspect code and report possible errors. It combines many different linting engines into a single tool. It works by providing a CLI which spins up a Docker instance for each plugin that is included in the `.codeclimate.yml` configuration. Because it uses Docker to spin up each linting instance, the Docker instance has to support Docker-in-Docker to function appropriately.

There is somewhat of a learning curve. To save some time, it is well worth it to read through the [Getting Started section in their help guide](https://docs.codeclimate.com/docs/advanced-configuration).

It is also **imperative** that once you have a grasp of how CodeClimate works that you read the **[CodeClimate Spec](https://github.com/codeclimate/platform/blob/master/spec/analyzers/SPEC.md)** which contains the technical details (including the format you should use when returning data). You should make your best effort to return as much useful data as possible using the CodeClimate Spec. However, sometimes it is not feasible (like in a case where you need to label 500 different linting rules with a category). At the very minimum, the engine should work flawlessly with GitLab's implementation of CodeClimate. You can view information (including sample data) on [GitLab's Code Quality help guide](https://docs.gitlab.com/ee/ci/testing/code_quality.html#implementing-a-custom-tool).

## Developing a New CodeClimate Engine

Developing a CodeClimate engine basically boils down to a few key elements:

1. Creating a Dockerfile which includes your linting engine and your custom scripts that adapt the linting engine for CodeClimate ([sample `Dockerfile`](https://gitlab.com/megabyte-labs/docker/codeclimate/flake8/-/blob/master/Dockerfile))
2. Developing scripts that parse the CodeClimate configuration and report the results in the [CodeClimate format](https://github.com/codeclimate/platform/blob/master/spec/analyzers/SPEC.md)
3. Including a binary-like file that serves as the entrance point for the scripts ([sample](https://gitlab.com/megabyte-labs/docker/codeclimate/flake8/-/blob/master/local/codeclimate-flake8))

You should also fill out the information in the `blueprint` section of the `package.json` file. Please refer to [some of our other CodeClimate engines](https://gitlab.com/megabyte-labs/docker/codeclimate) for examples of how this section should look. Our automated build scripts will read from `package.json` to populate the `engine.json` file which is kept in the `local/` folder.

You can find samples of CodeClimate engines we maintain by checking out our [CodeClimate Docker engine group on GitLab](https://gitlab.com/megabyte-labs/docker/codeclimate). You can also browse through the source code of official CodeClimate engines by browsing through [CodeClimate's GitHub](https://github.com/codeclimate).

When developing any project (including a CodeClimate engine) that is part of our eco-system, you should also make sure you structure the project according to the guidelines in our [Docker Style Guide](https://gitlab.com/megabyte-labs/templates/docker). Using the same design patterns across all of our repositories helps with automation and testing so it is very important.

## How to Run CodeClimate

To run CodeClimate, add a `.codeclimate.yml` file in the root of the repository you would like to inspect (locally, if you wish). Then run `codeclimate analyze`. Be sure to checkout `codeclimate --help` for some other useful commands. The following `codeclimate.yml` file would run the ESLint and ShellCheck CodeClimate engine:

```
engines:
  eslint:
    enabled: true
  shellcheck:
    enabled: true
exclude_paths:
- "node_modules/**"
```

## CodeClimate Configuration

Each of our CodeClimate engines should support the ability to specify the location of the linting tool's configuration. The path of this configuration should be relative to the root of the repository. So, for instance, if the `.codeclimate.yml` file in the root of the repository (or anywhere, if the location is specified to the CodeClimate CLI) looks like this:

```
---
engines:
  eslint:
    enabled: true
    config:
      path: .config/eslint.js
  duplication:
    enabled: true
    config:
      path: .config/duplication.js
      languages:
        - javascript
        - python
exclude_paths:
- "node_modules/**"
- "test/**"
- "integration/**"
```

You can see that we have assigned two new fields called `path` under each plugin's `config` section. Each of our CodeClimate engines should run with either no configuration path specified or with one specified. The `.codeclimate.yml` file might not always be in the root of the repository though so you cannot parse the user's `.codeclimate.yml` file. Instead, you will have to check the `/config.json` file that gets injected into the Docker container that the CodeClimate CLI spins up to run each plugin's linter. For the ESLint plugin above, the `/config.json` file will look something like this:

```
{
  "config": {
    "path": ".config/eslint.js"
  }
  "include_paths": [
    ...
    ...
  ]
}
```

*TODO: To improve this documentation, include an actual example of the `/config.json` which might be useful to determine what `include_paths` is and how it can be useful. It would also be nice to see the other pieces of data that `/config.json` contains.*

Using the `/config.json` file placed in the root of the container, you can access the appropriate settings regardless of where the `.codeclimate.yml` file is loaded from. Judging from other published repositories, you should include logic that handles the case where `/config.json` is not available though as well. You should assume that the `/config.json` and all of its data is optionally included. Whenever you think there is a useful option that you would pass directly to the engine's linter tool, you should include an option that is stored under the `config` of that particular linter. Whenever you do this, please add a section, brief note, and `.codeclimate.yml` sample to the `docs/partials/guide.md` file.

## The Dockerfile

There needs to be a `Dockerfile` included in each CodeClimate engine project. This `Dockerfile` should pre-install all the dependencies of the engine as well as perform optimizations to slim down the image size. The `Dockerfile` should strictly follow the same format outlined in our [Docker Style Guide](https://gitlab.com/megabyte-labs/templates/docker). When designing an engine, please read the guide, add the tests it asks for, and refer to our other CodeClimate engines if you need examples.

It is important to note that when the CodeClimate engine runs it will load all of the code in the current (or specified) directory into the `/code` directory. The `/work` directory you see in the `Dockerfile` is just an arbitrary folder used when building the image. So, for example, if you are constructing the path to the configuration mentioned above, you would combine `/code` + the `config.path` defined in the `/config.json` which is only available when the CodeClimate engine is being run.
