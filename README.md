# cb_docker
Dockerize Chicago Boss

## Build image base
The image base build is in `Makefile` with the version variable.
`make`

## Use image base
You only need in the root of your Chicago Boss project add a file
`Dokefile` like:
```Dockerfile
FROM cbdocker:latest
EXPOSE 80
```
**NOTE:** the image base it's not uploaded in Docker hub still. It'll be uploaded soon.

Automatically the work directory will be set in `/opt/cbapp` copy `.`
to the work directory and run `rebar compile` for with the entry point
from base image run a script and it will manage the start and graceful
stop of your project.
