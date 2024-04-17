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
${PYTHON} install.py --prefix="${PREFIX}" \
  --build_type="Release" \
  --allow-milps \
  ${skiprpath} \
  -DCMAKE_C_COMPILER=${GCC} \
  -DCMAKE_CXX_COMPILER=${CXX} \
  -Dsite_packages="\${SP_DIR}" \
  --clean-build -j 4 #"${CPU_COUNT}"

mkdir ${SP_DIR}/cyclus
cp ${SRC_DIR}/build/cyclus/*.py ${SP_DIR}/cyclus/
cp ${SRC_DIR}/build/cyclus/*.so ${SP_DIR}/cyclus/
cp ${SRC_DIR}/build/lib/eventhooks.so ${SP_DIR}/eventhooks.so
cp ${SRC_DIR}/build/lib/pyinfile.so ${SP_DIR}/pyinfile.so
cp ${SRC_DIR}/build/lib/pymodule.so ${SP_DIR}/pymodule.so
cp ${SRC_DIR}/src/hdf5_back_gen.py ${SP_DIR}/hdf5_back_gen.py
cp ${SRC_DIR}/build/cyclus/cycpp.py ${SP_DIR}/cycpp.py