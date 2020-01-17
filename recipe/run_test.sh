#!/bin/sh
# setup env for tests
cd tests

# check that the files exist
test -f ${PREFIX}/bin/cyclus
test -f ${PREFIX}/bin/cycpp.py
test -f ${PREFIX}/share/cyclus/cyclus_default_unit_test_driver.cc
test -f ${PREFIX}/share/cyclus/cyclus-flat.rng.in
test -f ${PREFIX}/share/cyclus/cyclus_nuc_data.h5
test -f ${PREFIX}/share/cyclus/cyclus.rng.in
test -f ${PREFIX}/share/cyclus/dbtypes.json

# output cyclus info
which cyclus

${PREFIX}/bin/cyclus --version
${PREFIX}/bin/cyclus --path
${PREFIX}/bin/cyclus --include
${PREFIX}/bin/cyclus --install-path
${PREFIX}/bin/cyclus --cmake-module-path
${PREFIX}/bin/cyclus --build-path
${PREFIX}/bin/cyclus --rng-schema
${PREFIX}/bin/cyclus --nuc-data

# run unit tests
${PREFIX}/bin/cyclus_unit_tests

# run integration tests
export PYTHONWARNINGS="ignore"

nosetests cycpp_tests.py
nosetests test_include_recipe.py
nosetests test_null_sink.py test_source_to_sink.py
nosetests test_trivial_cycle.py test_inventories.py
nosetests test_minimal_cycle.py
nosetests test_cycluslib.py
