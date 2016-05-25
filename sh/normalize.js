function normalize(dateStart, dateEnd, wholeDischarge) {
    'use strict';
    // time diff in seconds
    var ds = (dateEnd - dateStart) / 1000;
    console.log(ds)
    // time of test based on mean time of one probe
    var pt = (ds / 9) * 10;
    // horly rate
    var r  = 1 / (pt / 3600);

    return (r * wholeDischarge);
}

function now() {
    var now = now = new Date();
    var month = now.getMonth() + 1;
    return (now.getFullYear() + '-' + (month > 9 ? month : '0' + month)
        + '-' + now.getDate());
}

function normalizeInteractive() {
    'use strict';

    try {
        var str_now         = now();
        var dateStartString = prompt('Enter date and time of start', str_now);
        var dateEndString   = prompt('Enter date and time of end', str_now);
        var dateStart       = new Date(dateStartString);
        var dateEnd         = new Date(dateEndString);
        var value           = document//
                .querySelector('#DataTables_Table_6 > tbody > tr:nth-child(4) > td:nth-child(2)')//
                .textContent;

        value = value.replace('%', '') * 1.0; // remove precent, cast to float
        alert(normalize(dateStart, dateEnd, value));
    } catch (e) {
        (console && console.error && console.error(e.message));
    }
}
