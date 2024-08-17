#!/usr/bin/env python3

import re
import sys


def check_color(coords: str) -> bool:
    '''Determine if a coordinate on a chess board is light'''

    # Check if the position is valid
    if not re.search('^[a-h][1-8]$', coords):
        raise ValueError('Not a valid chess coordinate!')

    if coords[0] in ('a', 'c', 'e', 'g') and int(coords[1]) % 2 == 0:
        return True
    if coords[0] in ('b', 'd', 'f', 'h') and int(coords[1]) % 2 == 1:
        return True
    return False


def main():
    result = check_color(sys.argv[1])
    print('true' if result else 'false')


if __name__ == '__main__':
    main()
