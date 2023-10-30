#!/usr/bin/env python3

import sys


def main(ints):
    total = 0
    solution = []

    for i in ints:
        total += i
        solution.append(total)

    print('(' + ', '.join(map(str, solution)) + ')')


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
