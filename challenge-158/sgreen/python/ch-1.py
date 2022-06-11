#!/usr/bin/env python3

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


def main():
    primes = set()
    additive_primes = []

    for x in range(101):

        if not is_prime(x):
            continue

        primes.add(x)

        # Get the sum of all the digits
        s = sum(int(i) for i in str(x))

        if s in primes:
            # It's an additive prime!
            additive_primes.append(x)

    print(*additive_primes, sep=', ')


if __name__ == '__main__':
    main()
