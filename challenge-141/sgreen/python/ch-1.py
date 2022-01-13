#!/usr/bin/env python

def divisors(number):
    # One only has one divisor
    if number == 1:
        return 1

    # All other numbers have 1 and itself as divisors
    divisors = 2

    # Find other divisors
    for i in range(2, int(number/2)+1):
        if number % i == 0:
            divisors += 1

    return divisors


def main():
    number = 1
    solutions = []

    while (len(solutions) < 10):
        if divisors(number) == 8:
            solutions.append(number)
        number += 1

    print(*solutions, sep=', ')


if __name__ == '__main__':
    main()
