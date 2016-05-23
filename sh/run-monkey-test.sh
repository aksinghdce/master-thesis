package='pl.grzeniu.mt'
activity="${package}.ItemListActivity"

if [ $# -lt 1 ]; then
    echo 'Need monkey script file name passed as argument'
    exit 1
fi

ts_start=$(date '+%s')
# reset system stats

# reset activity under test
am force-stop "${package}"
am start "${package}/${activity}"
# run monkey script
monkey -p "${package}" -f "$1" 1

# check for error
monkey_return=$?

if [ $monkey_return -ne 0 ]; then
    echo "monkey script retuned error code ${monkey_return}"
    exit 2
fi

# dump stats
file_name="${1}_${ts_start}"
echo "${file_name}"
bugreport > "${file_name}"
