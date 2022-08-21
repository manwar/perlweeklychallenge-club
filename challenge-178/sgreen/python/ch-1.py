#!/usr/bin/env python

import sys


def main(num):
    digits = []

    while num >= 4 or num < 0:
        num, rem = divmod(num, -4)

        if rem < 0:
            num += 1
            rem += 4

        digits.append(str(rem))

    digits.append(str(num))

    # The actual digits is the number reversed, separated by zeros
    print('0'.join(digits[::-1]))


if __name__ == '__main__':
    main(int(sys.argv[1]))
