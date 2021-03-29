#!/usr/bin/python

import sys
input = int(sys.argv[1]) if len(sys.argv) > 1 else 248832
for i in range(1, 11):
    root = input ** (1/i)
    print('{:2d}'.format(i), "   ", root)
