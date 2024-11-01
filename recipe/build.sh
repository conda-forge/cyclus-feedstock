#!/usr/bin/env bash
set -e

# Install Cyclus
#export VERBOSE=1
${PYTHON} install.py \
  --prefix=${PREFIX} \
  ${CMAKE_ARGS} \
  --allow-milps \
  -DCMAKE_C_COMPILER=${CC} \
  -DCMAKE_CXX_COMPILER=${CXX} \
  -DPYTHON_SITE_PACKAGES="${SP_DIR}" \
  -j "${CPU_COUNT}"
