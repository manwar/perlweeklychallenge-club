#!/usr/bin/env python3

import math
import sys


def is_prime(number):
    '''Return true or false if the number is a prime'''
    if number < 2:
        return False

    for i in range(2, int(math.sqrt(number)) + 1):
        if number % i == 0:
            return False

    # It's a prime
    return True


def main(n):
    # Count the number of primes
    count = 0

    # Iterate from 1 to n
    for i in range(1, n+1):
        # If it is a prime, add to count
        if is_prime(i):
            count += 1

    print(count)


if __name__ == '__main__':
    main(int(sys.argv[1]))
