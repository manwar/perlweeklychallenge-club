#!/usr/bin/env python

import sys

fibs = [0, 1]


def is_sum_fib(n):
    global fibs

    # Make sure we have all fibonacci numbers <= n
    while (fibs[-1] < n):
        fibs.append(fibs[-2] + fibs[-1])

    return True if n in fibs else False


def get_sum(n):
    # Get the sum of all the digits
    sum = 0
    for digit in str(n):
        sum += int(digit)
    return sum


def main(n):
    value = 0
    solutions = []

    # Keep going until we have n solutions.
    while len(solutions) < n:
        # If the sum of this number is a fibannoci number, add it
        if is_sum_fib(get_sum(value)):
            solutions.append(value)
        value += 1

    print(*solutions, sep=', ')


if __name__ == '__main__':
    main(int(sys.argv[1]))
