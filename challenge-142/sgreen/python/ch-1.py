#!/usr/bin/env python

import sys


def _get_divisors(number):
    # Every number is divisible by 1
    divisors = [1]

    # One only has one divisor
    if number == 1:
        return divisors

    # Find other divisors
    for i in range(2, int(number / 2) + 1):
        if number % i == 0:
            divisors.append(i)

    # ... including the number itself
    divisors.append(number)

    return divisors


def main(inputs):
    m = int(inputs[0])
    n = int(inputs[1])

    if m < 1:
        raise ValueError('The first number must be a positive integer')
    if n < 1 or n > 9:
        raise ValueError('The second number must be between 1 and 9')

    # Get a list of divisors and find those that end with n.
    solution = [x for x in _get_divisors(m) if x % 10 == n]
    print(len(solution))


if __name__ == '__main__':
    main(sys.argv[1:])
