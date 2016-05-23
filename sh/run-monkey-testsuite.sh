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
if [ ! -d "${1}" ]; then
    echo 'Need path to directory containing tests to run'
    exit 1
fi

# how many timest to repeat a given test
if [ "${2}" -lt 1 ]; then
    repeat=1
else
    repeat=$2
fi

dst_dir='bugreports/'

# create destination directory if not present
mkdir -p "${dst_dir}"

# run tests
for test in $(ls "${1}"); do
    test_path=$(basename "${1}")"/${test}"
    echo "Running tests from file ${test_path}"

    for i in $(seq $repeat); do
        sh run-monkey-test.sh "${test_path}" "${dst_dir}"
    done
done
