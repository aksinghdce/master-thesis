#!/bin/bash
#
PACKAGE='pl.grzeniu.mt'
ACTIVITY='ItemListActivity'
adb shell am force-stop $PACKAGE
monkeyrunner test1.py $PACKAGE $PACKAGE.$ACTIVITY
