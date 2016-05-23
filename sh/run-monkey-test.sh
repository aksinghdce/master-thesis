# script for runnig a single monkey test
# test steps are contained in a file pointed to by an input argument
package='pl.grzeniu.mt'
activity="${package}.ItemListActivity"

test_script="${1}"
test_start=$(date '+%s')

if [ ! -f "${test_script}" ]; then
    echo 'Need monkey script file name passed as argument'
    exit 1
fi


function _runMonkey() {
    # reset activity under test
    am force-stop "${package}"
    am start "${package}/${activity}"
    # run monkey script
    monkey -p "${package}" -f "${1}" 1

    return "${?}"
}

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

function _dumpStats() {
    echo "${1}"
    bugreport > "${1}"

    return '0'
}


# reset system stats
_resetStats
_runMonkey "${test_script}"
_dumpStats "bugreports/${test_script}_${test_start}"
