#!/bin/env python
" Task 2 Challenge 085 "

from math import log, sqrt


def is_power_two_integers(what):
    " Find out if the number can be represented as x^y "

    if what == 1:
        return 1

    for i in range(2, int(sqrt(what)) + 1):
        diff = log(what) / log(i)

        if diff - int(diff) < 0.00000001:
            return 1

    return 0


assert is_power_two_integers(8) == 1
assert is_power_two_integers(15) == 0
assert is_power_two_integers(125) == 1
assert is_power_two_integers(625) == 1
