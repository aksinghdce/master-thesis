To run a test suite you must follow these steps:

  - copy the run-monkey-testsuite, run-monkey-test, test directories
    to a location on a device (SD card would be fine),

  - from the containing directory type run the following
    nohup sh run-monkey-testsuite PATH_TO_TESTS,

  - after all tests finish the subdirectory bugreports should contained
    files with bugreports bound to run tests.
    Output file name is as follows: {name_of_test}_{timestamp_of_test_star},

  - copy the bugreport files to your local machine, e.g. adb pull file_name
