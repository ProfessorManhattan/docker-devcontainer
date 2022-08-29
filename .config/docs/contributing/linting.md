## Linting

We utilize several different linters to ensure that all our Dockerfile projects use similar design patterns. Linting sometimes even helps spot errors as well. The most important linter for Dockerfile projects is called [Haskell Dockerfile Linter]({{ website.hadolint_github_page }}) (or hadolint). We also use many other linting tools depending on the file type. Simply run `git commit` to invoke the pre-commit hook (after running `bash start.sh` ahead of time) to automatically lint the changed files in the project.

Some of the linters are also baked into the CI pipeline. The pipeline will trigger whenever you post a commit to a branch. All of these pipeline tasks must pass in order for merge requests to be accepted. You can check the status of recently triggered pipelines for this project by going to the [CI/CD pipeline page]({{ repository.group.dockerfile }}/{{ subgroup }}/{{ slug }}/-/pipelines).
