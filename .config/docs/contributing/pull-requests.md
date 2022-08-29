## Pull Requests

All pull requests should be associated with issues. You can find the [issues board on GitLab]({{ repository.group.dockerfile }}/{{ subgroup }}/{{ slug }}/-/issues). The pull requests should be made to [the GitLab repository]({{ repository.group.dockerfile }}/{{ subgroup }}/{{ slug }}) instead of the [GitHub repository]({{ profile.github }}/docker-{{ slug }}). This is because we use GitLab as our primary repository and mirror the changes to GitHub for the community.

### Pre-Commit Hook

Even if you decide not to use `npm run commit`, you will see that `git commit` behaves differently because there is a pre-commit hook that installs automatically after you run `npm i` (or `bash start.sh`). This pre-commit hook is there to test your code before committing and help you become a better coder. If you need to bypass the pre-commit hook, then you may add the `--no-verify` tag at the end of your `git commit` command and `HUSKY=0` at the beginning (e.g. `HUSKY=0 git commit -m "Commit" --no-verify`).
