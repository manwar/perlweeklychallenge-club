#!/usr/bin/env python

import sys


def main(array):
    array = sorted(array)
    solution1 = array[-3] * array[-2] * array[-1]
    solution2 = array[0] * array[1] * array[-1]
    print(max(solution1, solution2))


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
