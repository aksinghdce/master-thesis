# run-monkey-testsuite.sh
# Script runs a whole monkey test suite.
# Runs all scripts contained in the input directory.
#
# Usage:
#   sh run-monkey-testsuite.sh test_dir [test_repeat]
#
# Arguments:
#   test_dir    – Required, directory containing test scenarios
#
#   test_repeat – Optional, how many times to repeat a given test
#
test_dir="${1}"

if [ ! -d "${test_dir}" ]; then
    echo 'Need path to directory containing tests to run'
    exit 1
fi

# how many timest to repeat a given test
if [ "${2}" -lt 1 ]; then
    repeat=1
else
    repeat=$2
fi

# import library script
source 'run-monkey-lib.sh'

# setup runtime options
out_dir='bugreports/'
package='pl.grzeniu.mt'
activity="${package}.ItemListActivity"
# create destination directory if not present
mkdir -p "${out_dir}"
# remove old reports
# rm bugreports/* didn't work on this environment
find "${out_dir}" -type f -exec rm {} \;

# run tests
for test_file in $(ls "${test_dir}"); do
    test_start=$(date '+%s')
    test_path=$(basename "${test_dir}")"/${test_file}"

    echo 'Reseting stats'
    _resetStats

    echo "Running tests from file ${test_path} ${repeat} time(s)"
    for i in $(seq $repeat); do
        _runMonkey "${package}" "${activity}" "${test_path}"
    done

    echo 'Dumping stats'
    _dumpStats "${out_dir}"$(basename "${test_file}")"_${test_start}"
done
