#!/usr/bin/env python3

import sys


def main(s):
    # Start at zero
    d_count = 0
    i_count = 0
    solution = [ 0 ]

    for c in s:
        if c == 'D':
            # We want a lower number
            d_count -= 1
            solution.append(d_count)
        else:
            # We want a higher number
            i_count += 1
            solution.append(i_count)

    # Rebase the list to start with zero
    solution = map(lambda i: i - d_count, solution)
    print(*solution, sep = ', ')

if __name__ == '__main__':
    main(sys.argv[1])
