# run-monkey-testsuite.sh
# Script runs a whole monkey test suite.
# Runs all scripts contained in the input directory.

if [ ! -d "${1}" ]; then
    echo 'Need path to directory containing tests to run'
    exit 1
fi

if [ ! -d 'bugreports/' ]; then
    mkdir 'bugreports/'

    if [ $? -ne 0 ]; then
        echo 'could not create bugreports/ direcotry'
        exit 2
    fi
fi

# wait for user input, so he can disconnect the device
read -p 'Press RETURN to start tests...' ignore

for test in $(ls "${1}"); do
    echo "Running tests from file ${1}"
    sh run-monkey-test.sh "${test}"
done
