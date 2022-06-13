#!/usr/bin/env python3

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


def get_bril_nums(l):
    '''Get all primes of length l'''

    primes = []
    for i in range(10**(l-1), 10**l):
        if is_prime(i):
            primes.append(i)

    # Calculate all brilliant numbers
    bril_nums = []
    for i, v1 in enumerate(primes):
        for v2 in primes[i:]:
            bril_nums.append(v1*v2)

    # Return the sorted list
    bril_nums.sort()
    return bril_nums


def main():
    '''Find the first twenty brilliant numbers'''
    l = 1
    bril_nums = []

    # Keep increasing the length of primes until we have at least twenty
    #  solutions
    while len(bril_nums) < 20:
        bril_nums.extend(get_bril_nums(l))
        l += 1

    # Print the first 20 numbers
    print(*bril_nums[0:20], sep=', ')


if __name__ == '__main__':
    main()
