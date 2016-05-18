# -*- coding: UTF-8 -*-
import sys, os

from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice

package  = sys.argv[1]
activity = sys.argv[2]

print('Running ' + os.path.basename(sys.argv[0]) + ' for activity ' + activity + '\n')

device = MonkeyRunner.waitForConnection()
device.startActivity(component = (package + '/' + activity))

print('\ndone...')
