#!/usr/bin/env python3

import sys


def main(nums):
    # Get the last number as the number to compare
    n = float(nums.pop())

    # Get all numbers > n
    l = [i for i in nums if float(i) > n]

    # Print the numbers
    print(*l, sep=', ')


if __name__ == '__main__':
    main(sys.argv[1:])
