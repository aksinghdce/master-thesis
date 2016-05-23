# -*- coding: UTF-8 -*-
import sys, os

from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice

test     = os.path.basename(sys.argv[0])
package  = sys.argv[1]
activity = sys.argv[2]

timeout = 1.0
offset  = 160

# wraps waiting for s seconds and emulating touch on given x & y
def touch(x, y, s = timeout):
    MonkeyRunner.sleep(s)
    device.touch(left + x, top + y, MonkeyDevice.DOWN_AND_UP)

# wraps waiting for s seconds and emulating triggering a given event
def press(k = 'KEYCODE_BACK', s = timeout):
    MonkeyRunner.sleep(s)
    device.press(k, MonkeyDevice.DOWN_AND_UP)

print('Running ' + test + ' for activity ' + activity)
device = MonkeyRunner.waitForConnection()
device.startActivity(component = (package + '/' + activity))


for list_item in range(6):
    # every car wash
    MonkeyRunner.sleep(timeout)
    device.touch(50, 210 + 100 * list_item, MonkeyDevice.DOWN_AND_UP)

    # every menu item
    for menu_item in range(5):
        MonkeyRunner.sleep(timeout)
        device.touch(50, 450 + 90 * menu_item, MonkeyDevice.DOWN_AND_UP)
        MonkeyRunner.sleep(timeout * 3)
        device.press('KEYCODE_BACK', MonkeyDevice.DOWN_AND_UP)

    MonkeyRunner.sleep(timeout)
    device.press('KEYCODE_BACK', MonkeyDevice.DOWN_AND_UP)

print('\ndone...')
