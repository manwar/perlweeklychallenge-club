#!/usr/bin/env python3

import sys


def count_primes(i):
    '''Calculate the number of primes that make up the specified number'''
    primes = 0
    count = 2

    while i > 1:
        if i % count == 0:
            primes += 1
            i = i / count
        else:
            count += 1

    return primes


def main(ints):
    primes = {}
    for i in ints:
        # Calculate the steps required for each int to get a single digit
        primes[i] = count_primes(i)

    # Sort the integers in ascender order, and then by the steps required
    sorted_ints = sorted(ints)
    sorted_ints = sorted(sorted_ints, key=lambda i: primes[i])

    print('(' + ', '.join(map(str, sorted_ints)) + ')')


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
