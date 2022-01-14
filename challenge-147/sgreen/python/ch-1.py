#!/usr/bin/env python

import math


def is_prime(number):
    # Return true or false if the number is a prime
    if number < 2:
        return False

    for i in range(2, int(math.sqrt(number)) + 1):
        if number % i == 0:
            return False

    # It's a prime
    return True


def is_trunc_prime(number):
    # Return true or false if the number and all it's left truncated
    #  parts is a prime. Start with the smallest figure first
    n = str(number)

    if '0' in n:
        # A left-truncatable prime cannot contain a zero
        return False

    for i in range(len(n), 0, -1):
        if not is_prime(int(n[i - 1:])):
            return False

    return True


def main():
    solutions = []
    number = 1

    # Keep increasing number by one until we have twenty truncated prime
    #  numbers
    while len(solutions) < 20:
        if is_trunc_prime(number):
            solutions.append(number)
        number += 1

    print(*solutions, sep=', ')


if __name__ == '__main__':
    main()
