#!/usr/bin/env bash
set -e

if [ "$(uname)" == "Darwin" ]; then
  # FIND_FRAMEWORK_NEVER="-DCMAKE_FIND_FRAMEWORK=NEVER"
  # FIND_APPBUNDLE_NEVER="-DCMAKE_FIND_APPBUNDLE=NEVER"
  BLAS_HINT="-DBLAS_ROOT=${CONDA_PREFIX}" # Tell CMake to use conda BLAS and not system BlAS
fi

# Install Cyclus
#export VERBOSE=1
${PYTHON} install.py \
  --prefix=${PREFIX} \
  ${CMAKE_ARGS} \
  # ${FIND_FRAMEWORK_NEVER} \
  # ${FIND_APPBUNDLE_NEVER} \
  ${BLAS_HINT} \
  --allow-milps \
  -DCMAKE_C_COMPILER=${CC} \
  -DCMAKE_CXX_COMPILER=${CXX} \
  -DPYTHON_SITE_PACKAGES="${SP_DIR}" \
  -j "${CPU_COUNT}"
