#!/usr/bin/env python3

import sys


def main(ints):
    # Determine the minimum and maximum values
    min_int = min(ints)
    max_int = max(ints)

    # Calculate list of values that are not minimum or maximum
    solution = [str(i) for i in ints if i != min_int and i != max_int]

    if len(solution):
        print('(' + ', '.join(solution) + ')')
    else:
        print('-1')


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
