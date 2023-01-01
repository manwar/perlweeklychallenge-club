#!/usr/bin/env python3

import sys


def main(n):
    # The solution is all the non-zero values ...
    solution = [i for i in n if i != 0]

    # ... followed by the zero values
    solution.extend([i for i in n if i == 0])

    print(*solution, sep=', ')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
