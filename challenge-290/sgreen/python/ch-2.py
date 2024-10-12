#!/usr/bin/env python3

import re
import sys


def luhn_algorithm(s: str) -> bool:
    # Remove any non-numeric characters, and turn it into a list of integers reversed
    s = re.sub('[^0-9]', '', s)
    ints = [int(n) for n in s[::-1]]

    count = 0
    for pos, i in enumerate(ints):
        if pos % 2 == 1:
            i *= 2
            if i > 9:
                i -= 9
        count += i
    return count % 10 == 0


def main():
    result = luhn_algorithm(sys.argv[1])
    print('true' if result else 'false')


if __name__ == '__main__':
    main()
