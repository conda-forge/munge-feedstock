#!/bin/bash

set -ex

mkdir -p _build
pushd _build

# configure
${SRC_DIR}/configure \
	--prefix=${PREFIX} \
	--with-crypto-lib=openssl \
	--with-openssl-prefix=${PREFIX} \
;

# build
make -j ${CPU_COUNT} V=1 VERBOSE=1

# run make check only on linux-64
# (unknown failures on other platforms)
if [ "${target_platform}" = "linux-64" ]; then
	make -j ${CPU_COUNT} V=1 VERBOSE=1 check ${CHECK_ARGS:-}
fi

# install
make -j ${CPU_COUNT} V=1 VERBOSE=1 install
