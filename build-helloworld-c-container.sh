#!/bin/bash

# THE FOLLOWING SCRIPT AIMS TO CREATE A CONTAINER
# USING buildah FROM SCRATCH

# Create the image from scratch
name=$(buildah from scratch)
buildah config --author "Giovanni Astarita" --label name "Test helloworld C program" $name

# Mount the root FS of the working-container
scratchmnt=$(buildah mount $name)

# Install bash & coreutils modules
dnf install --installroot $scratchmnt --releasever 8.3 bash coreutils --setopt install_weak_deps=false -y
dnf --installroot $scratchmnt clean all

# Copy the C binary program in the root folder
buildah copy $name ./helloworld /

# Create the necessary endpoint
buildah config --entrypoint ./helloworld $name

# Unmount the root FS
buildah umount $name

# Commit the built image in the local repository
buildah commit $name hello-world

# Delete working-container
buildah rm $name

# TO RUN THE CONTAINER TYPE:
#
# podman run --name test-helloworld-c hello-world
