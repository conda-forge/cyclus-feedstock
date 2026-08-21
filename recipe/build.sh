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
# cyclus otherwise derives DEPS_ROOT_DIR from the compiler location (BUILD_PREFIX)
${PYTHON} install.py --prefix="${PREFIX}" \
  --deps-root="${PREFIX}" \
  --allow-milps \
  ${skiprpath} \
  -DCMAKE_C_COMPILER=${GCC} \
  -DCMAKE_CXX_COMPILER=${CXX} \
  -DPython3_EXECUTABLE="${PYTHON}" \
  -DPYTHON_SITE_PACKAGES="${SP_DIR}" \
  -j "${CPU_COUNT}"
