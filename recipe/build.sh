#!/usr/bin/env bash
set -e

if [ "$(uname)" == "Darwin" ]; then
  # other
  libext=".dylib"
  export LDFLAGS=" "#-rpath ${PREFIX}/lib ${LDFLAGS}"
  #export LINKFLAGS="-t undefined dynamic_lookup ${LDFLAGS}"
  #export LDFLAGS="-t undefined dynamic_lookup ${LDFLAGS}"
  skiprpath="-DCMAKE_SKIP_RPATH=TRUE"
else
  libext=".so"
  skiprpath=""
fi



# Install Cyclus
#export VERBOSE=1
${PYTHON} install.py --prefix="${PREFIX}" \
  --build_type="Release" \
  --deps-root="${PREFIX}" \
  --core-version="${PKG_VERSION}" \
  -DBLAS_LIBRARIES="-L${PREFIX}/lib -lopenblas" \
  -DLAPACK_LIBRARIES="-L${PREFIX}/lib -lopenblas" \
  --dont-allow-milps \
  --clean -j "${CPU_COUNT}"
#  ${skiprpath} \
#  -DCMAKE_OSX_DEPLOYMENT_TARGET="${MACOSX_VERSION_MIN}" \
