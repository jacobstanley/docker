#!/bin/bash -e

DOCKER_TAG=centos6-ghc-7.10.1-prebuild

OUTDIR=./output

abspath () {
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

copy () {
    docker run \
        -v $(abspath $OUTDIR):/var/output:rw \
        $DOCKER_TAG \
        cp $1 /var/output
}

# Build container
docker build -t $DOCKER_TAG .

# Copy off the binaries
copy /root/ghc-7.10.1+Cabal-1.22.3.0.tar.xz
copy /root/cabal-install-1.22.4.0.tar.xz
copy /root/alex-3.1.4.tar.xz
copy /root/happy-1.19.5.tar.xz
copy /root/c2hs-0.25.2.tar.xz
