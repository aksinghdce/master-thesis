# -*- coding: UTF-8 -*-
import sys, os

from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice

test     = os.path.basename(sys.argv[0])
package  = sys.argv[1]
activity = sys.argv[2]

sleep = 1.0
left  = 50
top   = 160
elm_h = 175
swipe = 5   # swipe every x items

# wraps waiting for s seconds and emulating touch on given x & y
def touch(x, y, s = sleep):
    MonkeyRunner.sleep(s)
    device.touch(left + x, top + y, MonkeyDevice.DOWN_AND_UP)

# wraps waiting for s seconds and emulating triggering a given event
def press(k = 'KEYCODE_BACK', s = sleep):
    MonkeyRunner.sleep(s)
    device.press(k, MonkeyDevice.DOWN_AND_UP)

# returns y coordinate for list item with given index
def offsetForItem(itemIndex):

    if itemIndex <= 0:
        itemIndex = 0
    else:
        itemIndex -= 1

    return itemIndex * elm_h + top

def drag(from_y, to_y, duration = sleep):
    MonkeyRunner.sleep(sleep)
    device.drag((left, from_y), (left, to_y), duration, swipe)

def progress():
    sys.stdout.write('.')
    sys.stdout.flush()

print('Running ' + test + ' for activity ' + activity)
# start app
device = MonkeyRunner.waitForConnection()
device.startActivity(component = (package + '/' + activity))

MonkeyRunner.sleep(1.0)
item = 0

# touch sequence
for step in xrange(120):
    item += 1

    if item > swipe:
        drag(offsetForItem(item), offsetForItem(1))
        item = 1

    # see item i
    touch(10, offsetForItem(item))
    # go back to list
    press()
    progress()

print('\ndone...')
