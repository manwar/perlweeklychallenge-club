#!/usr/bin/env python3

import sys


def main(ints):
    solution = [ ints[ints[i]] for i in range(len(ints))]
    print(*solution, sep=', ')

if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
