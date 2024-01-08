#!/usr/bin/env python3

import re
import sys


def calculate_value(s):
    '''Return the number if it looks like an integer else the length of string'''
    return int(s) if re.search(r'^\d+$', s) else len(s)


def main(values):
    print(max(map(calculate_value, values)))


if __name__ == '__main__':
    main(sys.argv[1:])
