#!/usr/bin/env bash

set -ex

if [ "$(uname)" == "Darwin" ]; then
  # other
  libext=".dylib"
  export LDFLAGS="-rpath ${PREFIX}/lib ${LDFLAGS}"
  export LINKFLAGS="${LDFLAGS}"
  skiprpath="-DCMAKE_SKIP_RPATH=TRUE"
else
  libext=".so"
  skiprpath=""
fi

# Install Cyclus
#export VERBOSE=1
# --deps-root: cyclus otherwise derives DEPS_ROOT_DIR from the compiler location
# (BUILD_PREFIX)
# --slow: compiles the PyNE decay and CRAM solvers from decay.cpp and cram.c
# instead of downloading prebuilt {decay,cram}-<os>-<compiler>.s assembly, which
# is x86_64 only and fails to assemble on linux-aarch64 and osx-arm64
${PYTHON} install.py --prefix="${PREFIX}" \
  --deps-root="${PREFIX}" \
  --allow-milps \
  --slow \
  ${skiprpath} \
  -DCMAKE_C_COMPILER=${CC} \
  -DCMAKE_CXX_COMPILER=${CXX} \
  -DPython3_EXECUTABLE="${PYTHON}" \
  -DPYTHON_SITE_PACKAGES="${SP_DIR}" \
  -j "${CPU_COUNT}"
