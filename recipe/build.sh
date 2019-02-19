#!/usr/bin/env bash
set -e

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
ln -s $CPP /opt/conda/bin/cpp
${PYTHON} install.py --prefix="${PREFIX}" \
  --build_type="Release" \
  --dont-allow-milps \
  --deps-root="${PREFIX}" \
  --core-version="${PKG_VERSION}" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET="${MACOSX_VERSION_MIN}" \
  -DBLAS_LIBRARIES="${PREFIX}/lib/libblass.so" \
  -DLAPACK_LIBRARIES="${PREFIX}/lib/liblapack.so" \
  ${skiprpath} \
  --clean -j "${CPU_COUNT}"
