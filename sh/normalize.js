function normalize(dateStart, dateEnd, wholeDischarge) {
    'use strict';
    // time diff in seconds
    var ds = (dateEnd - dateStart) / 1000;
    // time of test based on mean time of one probe
    var pt = (ds / 9) * 10;
    // horly rate
    var r  = 1 / (pt / 3600);

    return r * wholeDischarge;
}
