#!/usr/bin/env pyhton3

import sys

if len(sys.argv) != 2:
    raise ValueError("Usage: {} coordinates".format(sys.argv[0]))

coords = sys.argv[1]
if not (len(coords) == 2 and coords[0] in 'abcdefgh' and coords[1] in '12345678'):
    raise ValueError("Usage: {} coordinates".format(sys.argv[0]))

light = ((ord(coords[0]) - ord('a')) & 1) ^ (int(coords[1]) - 1 & 1)
print("true" if light else "false")
