#!/usr/bin/env python

import sys


def main(array):
    solution = sorted([x ** 2 for x in array])
    print(*solution, sep=', ')


if __name__ == '__main__':
    array = [int(n) for n in sys.argv[1:]]
    main(array)
