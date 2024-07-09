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

# except on linux-64 just run a subset of the tests
if [ "${target_platform}" != "linux-64" ]; then
	CHECK_ARGS="TESTS=0012-munge-cmdline.t"
fi

# check (except when truly cross compiling)
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
	make -j ${CPU_COUNT} V=1 VERBOSE=1 check ${CHECK_ARGS:-}
fi

# install
make -j ${CPU_COUNT} V=1 VERBOSE=1 install
