#!/usr/bin/env bash
set -e

if [ "$(uname)" == "Darwin" ]; then
  FIND_FRAMEWORK_NEVER="-DCMAKE_FIND_FRAMEWORK=NEVER"
  FIND_APPBUNDLE_NEVER="-DCMAKE_FIND_APPBUNDLE=NEVER"
fi

# Install Cyclus
#export VERBOSE=1
${PYTHON} install.py \
  --prefix=${PREFIX} \
  ${CMAKE_ARGS} \
  ${FIND_FRAMEWORK_NEVER} \
  ${FIND_APPBUNDLE_NEVER} \
  --allow-milps \
  -DCMAKE_C_COMPILER=${CC_FOR_BUILD} \
  -DCMAKE_CXX_COMPILER=${CXX_FOR_BUILD} \
  -DPYTHON_SITE_PACKAGES="${SP_DIR}" \
  -j "${CPU_COUNT}"
