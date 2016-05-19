#!/usr/bin/env python
# -*- coding: UTF-8 -*-
from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice
from time import time, sleep
from sys import argv, stdout

# token "constants"
TOKEN_METHOD_TOUCH  = 1
TOKEN_METHOD_DRAG   = 2
TOKEN_METHOD_SLEEP  = 3
TOKEN_METHOD_BACK   = 4

time_start = time()
commands = 0

def spinner():
    token = ''
    if spinner.state == 0:
        token = '|'
    elif spinner.state == 1:
        token = '/'
    elif spinner.state == 2:
        token = '–'
    else:
        token = '\\'

    spinner.state = (spinner.state + 1) % 4
    stdout.write('\r' + token)
    stdout.flush()
spinner.state = 0

# setup environment
device = MonkeyRunner.waitForConnection()
device.startActivity(component = 'pl.grzeniu.mt/pl.grzeniu.mt.ItemListActivity')

# run commands
for line in open(argv[1]):
    tokens = [int(token) for token in line.rstrip('\n').split(' ')]
    # no tokens
    if len(tokens) <= 0:
        continue

    # execute monkeyrunner methods with given params
    if tokens[0] == TOKEN_METHOD_BACK:
        device.press('KEYCODE_BACK', MonkeyDevice.DOWN_AND_UP)
    elif tokens[0] == TOKEN_METHOD_DRAG:
        device.drag((tokens[1], tokens[2]), (tokens[3], tokens[4]))
    elif tokens[0] == TOKEN_METHOD_TOUCH:
        device.touch(tokens[1], tokens[2], MonkeyDevice.DOWN_AND_UP)
    elif tokens[0] == TOKEN_METHOD_SLEEP:
        MonkeyRunner.sleep(tokens[1])
    else:
        # unknown method
        continue
    sleep(1)
    commands += 1
    spinner()


print 'executed ', commands, ' commands'
print 'test took ', int(time() - time_start), ' seconds'
