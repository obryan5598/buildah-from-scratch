# Buildah from scratch

The following example shows how to create a container image
from scratch using buildah.

The container will print a C-language program hello-world.

## Prerequisites
Please check that the following packages are installed:
- podman
- buildah
- gcc

## Compiling hello.c
To create the binary of the hello.c program run
```bash
gcc -o helloworld hello.c
```

## Build the image with the compiled binary
Execution must be run in rootless mode invoking
the unshare command, like the example below:
```bash
buildah unshare bash build-helloworld-c-container.sh
```


## Run the container
```bash
podman run --name test-helloworld-c hello-world
``` 
