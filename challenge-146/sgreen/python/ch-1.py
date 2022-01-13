#!/usr/bin/env python

import math


def is_prime(number):
    for i in range(2, int(math.sqrt(number)) + 1):
        if number % i == 0:
            return False

    # One is not a prime, every other number is
    return True if number != 1 else False


def main():
    number = 0
    prime_count = 0

    while prime_count < 10001:
        number += 1
        if is_prime(number):
            prime_count += 1
    print(number)


if __name__ == '__main__':
    main()
