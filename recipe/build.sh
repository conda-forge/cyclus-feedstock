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

# ensure we find our libraries
export LD_LIBRARY_PATH="${PREFIX}/lib/:${LD_LIBRARY_PATH}"

# Install Cyclus
#export VERBOSE=1
${PYTHON} install.py \
  --prefix="${PREFIX}" \
  --cmake_prefix_path="${PREFIX}" \
  --deps_root="${PREFIX}" \
  --allow-milps \
  ${skiprpath} \
  -DCMAKE_C_COMPILER=${GCC} \
  -DCMAKE_CXX_COMPILER=${CXX} \
  -DCMAKE_LIBRARY_PATH="${PREFIX}/lib" \
  -DCMAKE_MODULE_PATH="${PREFIX}/lib/cmake" \
  -DPYTHON_SITE_PACKAGES="${SP_DIR}" \
  -j "${CPU_COUNT}"
