#!/usr/bin/env python

import math


def is_prime(number):
    '''Return true or false if the number is a prime'''
    if number < 2:
        return False

    for i in range(2, int(math.sqrt(number)) + 1):
        if number % i == 0:
            return False

    # It's a prime
    return True


def main():
    solutions = [1]
    value = 1
    counter = 0

    # We need 10 solutions
    while len(solutions) < 10:
        counter += 1
        if is_prime(counter):
            # Multiple the solution by this number
            value *= counter
            solutions.append(value)

    print(*solutions, sep=', ')


if __name__ == '__main__':
    main()
