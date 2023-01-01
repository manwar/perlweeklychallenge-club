#!/usr/bin/env python3

from itertools import chain, zip_longest
import sys


def main(n):
    # Sort the list, find the mid point
    n = sorted(n, reverse=True)
    mid_point = len(n) // 2

    # Split the list into big_n and small_n
    big_n = n[:mid_point]
    small_n = n[mid_point:]

    # Merge the lists together
    solution = [i for i in chain(
        *zip_longest(small_n, big_n)) if i is not None]

    # There is no solution if two subsequent numbers are equal
    if any(solution[i-1] == solution[i] for i in range(1, len(solution))):
        print('No solution possible!')
    else:
        print(*solution, sep=', ')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
