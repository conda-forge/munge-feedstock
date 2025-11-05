#!/bin/bash

set -ex

mkdir -p _build
pushd _build

# configure
${SRC_DIR}/configure \
	--prefix=${PREFIX} \
	--with-munge-socket="/var/run/munge/munge.socket.2" \
	--with-crypto-lib=openssl \
	--with-openssl-prefix=${PREFIX} \
;

# build
make -j ${CPU_COUNT} V=1 VERBOSE=1

# install
make -j ${CPU_COUNT} V=1 VERBOSE=1 install
