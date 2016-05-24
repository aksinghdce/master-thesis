# -*- coding: UTF-8 -*-
from random import random

# Pseudo random decision maker.
# Returns True if randomly generated number is less than given threshold
def yesno(threshold = 0.5):
    if threshold < 0 or threshold > 1:
        threshold = 0.5
    return (random() <= threshold)


def wait(seconds):
    print('UserWait(' + str(int(seconds * 1000)) + ')')

def header():
    # prints required script header
    print('type=user\ncount=49\nspeed=1.0\nstart data >>')
    # initial timeout
    wait(2)

# prints a touch command sequnce
def touch(x, y):
    print('DispatchPointer(0, 0, 0, ' + str(x) + ', ' + str(y) + ', 1, 1, 0, 1, 1, 0, 0)')
    wait(0.1)
    print('DispatchPointer(0, 0, 1, ' + str(x) + ', ' + str(y) + ', 1, 1, 0, 1, 1, 0, 0)')


# prints a back button pressed command
def back():
    print('DispatchPress(KEYCODE_BACK)')

# prints a drag command sequnce
def drag(x_from, y_from, x_to, y_to):
    # press
    print('DispatchPointer(0, 0, 0, ' + str(x_from) + ', ' + str(y_from) + ', 1, 1, 0, 1, 1, 0, 0)')
    wait(0.1)
    # move
    print('DispatchPointer(0, 0, 2, ' + str(x_to) + ', ' + str(y_to) + ', 1, 1, 0, 1, 1, 0, 0)');
    wait(0.1)
    # release
    print('DispatchPointer(0, 0, 1, ' + str(x_to) + ', ' + str(y_to) + ', 1, 1, 0, 1, 1, 0, 0)');
