#!/usr/bin/env python3

import sys


def main(ints):
    solution = [sum(1 for j in ints if j < i) for i in ints]
    print(*solution, sep=', ')


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
