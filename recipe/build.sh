#!/bin/bash

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

# check
if [[ "${build_platform}" == "${target_platform}" || "${target_platform}" == linux-* ]]; then
	make -j ${CPU_COUNT} V=1 VERBOSE=1 check
fi

# install
make -j ${CPU_COUNT} V=1 VERBOSE=1 install
