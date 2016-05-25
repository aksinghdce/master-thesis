# run-monkey-lib.sh
#
# Contains common functions used when running monkey test suites
#


#
# Tries to reset all system services and clears all logcat buffers.
# This effectively resets a battery-historian report.
#
function _resetStats() {
    # reset services (not all support this option though; so have to redirect all output)
    for service in 'accessibility' 'account' 'activity' 'alarm' 'android.security.keystore'\
        'android.service.gatekeeper.IGateKeeperService' 'appops' 'appwidget' 'assetatlas' 'AtCmdFwd' 'audio' 'backup'\
        'battery' 'batteryproperties' 'batterystats' 'bluetooth_manager' 'carrier_config' 'CCModeService' 'clipboard'\
        'cliptray' 'com.lge.ims.phone' 'commontime_management' 'com.qualcomm.location.izat.IzatService' 'com.qualcomm.qti.auth.fidocryptodaemon'\
        'connectivity' 'consumer_ir' 'content' 'country_detector' 'cpuinfo' 'dbinfo' 'deathmonitor' 'deviceidle' 'device_policy'\
        'devicestoragemonitor' 'diskstats' 'display' 'display.qservice' 'DockObserver' 'dreams' 'drm.drmManager' 'dropbox'\
        'emotionled' 'encryption' 'extphone' 'fingerprint' 'fingerprint_ex' 'gfxinfo' 'glanceview' 'gmeminfo' 'graphicsstats'\
        'imms' 'input' 'input_method' 'iphonesubinfo' 'isms' 'isub' 'jobscheduler' 'Jphone' 'launcherapps' 'lg_bluetoothapi_service'\
        'lgdatascheduler' 'lgdevencryption' 'lgdisplay' 'lgdrm' 'lghashstorage' 'lgmdm_device_policy_manager' \
        'lgnetworkmanagementservice' 'lgpowermanagerhelper' 'lgsdencryption' 'lgsecclk' 'lguicc' 'lguiccpbm' 'location'\
        'lock_settings' 'logcatcher' 'media.allegro_service' 'media.audio_flinger' 'media.audio_policy' 'media.camera'\
        'media.camera.proxy' 'media.player' 'media_projection' 'media.radio' 'media.resource_manager' 'media_router'\
        'media_session' 'media.sound_trigger_hw' 'meminfo' 'midi' 'mount' 'netpolicy' 'netstats' 'network_management'\
        'network_score' 'nfc' 'nfcaddon' 'nfcLgService' 'nfcoperator' 'nfcvendor' 'notification' 'nvitemservice' 'osservice'\
        'package' 'permission' 'phone' 'power' 'print' 'processinfo' 'procstats' 'qtitetherservice' 'restrictions'\
        'rttmanager' 'samplingprofiler' 'scheduling_policy' 'search' 'sensorservice' 'serial' 'servicediscovery'\
        'simphonebook' 'smartcover' 'statusbar' 'SurfaceFlinger' 'telecom' 'telephony.registry' 'textservices' 'themeicon'\
        'trust' 'uimode' 'updatelock' 'usagestats' 'usb' 'user' 'vibrator' 'voiceinteraction' 'volumevibrator' 'wallpaper'\
        'webviewupdate' 'wifi' 'wifiExtService' 'wifiLgeExtService' 'wifip2p' 'wifiSapService' 'wifiscanner' 'window'
    do
        dumpsys "${service}" --reset &>/dev/null
    done

    # reset logcat buffers
    logcat -c -b 'all'

    return '0'
}

#
# Runs a monkey script for given package.
#
# @param string package name
# @param string activity class
# @param string script file to run
#
function _runMonkey() {
    # reset activity under test
    am force-stop "${1}"
    am start "${1}/${2}"
    # run monkey script
    monkey -p "${1}" -f "${3}" 1
    # stop application after tests
    am force-stop "${1}"

    return "${?}"
}

#
# Dumps a bugreport to given file
#
# @param string report file
#
function _dumpStats() {
    bugreport > "${1}"

    return '0'
}
