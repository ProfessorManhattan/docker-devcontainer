## Getting Started

To get started when developing one of [our Dockerfile projects]({{ repository.group.dockerfile }}) (after you have installed [Docker]({{ repository.project.docker }})), the first command you need to run in the root of the project is:

```shell
bash start.sh
```

This command will ensure the dependencies are installed and update the project to ensure upstream changes are integrated into the project. You should run it anytime you step away from a project (just in case changes were made to the upstream files).

### Creating DockerSlim Builds

Whenever possible, a DockerSlim build should be provided and tagged as `:slim`. DockerSlim provides many configuration options so please check out the [DockerSlim documentation]({{ website.dockerslim_github_page }}) to get a thorough understanding of it and what it is capable of. When you have formulated _and fully tested_ the proper DockerSlim configuration, you will need to add to the `blueprint` section of the `package.json` file. **More details on this are in our [Docker Style Guide](https://gitlab.com/megabyte-labs/templates/docker).**

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
