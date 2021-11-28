#!/usr/bin/env python

import math


def is_prime(number):
    for i in range(2, int(math.sqrt(number)) + 1):
        if number % i == 0:
            return False

    return True


def long_division(number):
    digits = 0

    r = 10 % number
    seen = {r: 1}

    while 1:
        digits += 1
        r = (10 * r) % number
        if r in seen:
            return digits
        seen[r] = 1


def main():
    number = 2
    solutions = []

    while 1:
        number += 1
        if is_prime(number) and long_division(number) == number - 1:
            solutions.append(number)
        if len(solutions) == 5:
            break

    print(*solutions, sep=', ')


if __name__ == '__main__':
    main()
