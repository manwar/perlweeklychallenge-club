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
    cuban_primes = []
    x = 1

    while x:
        # Calculate 3x² + 3x + 1
        p = 3 * x * x + 3 * x + 1

        if p > 1000:
            # We only care about values <= 1000
            break

        if is_prime(p):
            # Add to the cuban_primes list
            cuban_primes.append(p)

        x += 1

    print(*cuban_primes, sep=', ')


if __name__ == '__main__':
    main()
