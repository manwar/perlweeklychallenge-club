#!/usr/bin/env python3

import sys

def digit_count_true(ints):
    count = {}
    for i in range(len(ints)):
        count[i] = 0
    for x in ints:
        if x in count:
            count[x] += 1
        else:
            count[x] = 1
    for i in range(len(ints)):
        if count[i] != ints[i]:
            return False
    return True

ints = [int(x) for x in sys.argv[1:]]
print('true' if digit_count_true(ints) else 'false')
