#!/usr/bin/env python3

import sys


def main(s):
    # Sort the list numerically
    nums = [int(x) for x in s]
    nums.sort()

    print(1 if nums[-1] > 2 * nums[-2] else -1)


if __name__ == '__main__':
    main(sys.argv[1:])
