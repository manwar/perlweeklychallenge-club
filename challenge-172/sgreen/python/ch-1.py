#!/usr/bin/env python

import sys
import math
from itertools import combinations


def is_prime(number):
    '''Return true or false if the number is a prime'''
    if number < 2:
        return False

    for i in range(2, int(math.sqrt(number)) + 1):
        if number % i == 0:
            return False

    # It's a prime
    return True


def main(m, n):
    # Retrieve a list of all prime numbers <= m
    primes = [x for x in range(m, 1, -1) if is_prime(x)]

    # Go through each combination of n length, and see if we have a solution
    for l in combinations(primes, n):
        if sum(l) == m:
            print(l, sep=', ')
            return

    # It is possible that no solution is found
    print('No solution!')


if __name__ == '__main__':
    main(int(sys.argv[1]), int(sys.argv[2]))
