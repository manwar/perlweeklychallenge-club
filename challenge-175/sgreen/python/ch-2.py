#!/usr/bin/env python3

import math

primes = []
factors = {}
totients = {}


def is_prime(number):
    '''Return true or false if the number is a prime'''
    if number < 2:
        return False

    for i in primes:
        if number % i == 0:
            return False

    # It's a prime
    return True


def get_factors(num):
    '''Get the prime factors that make up the numbers'''
    global factors

    if num not in factors:
        factors[num] = set()

        for p in primes:
            if num % p == 0:
                factors[num].add(p)

    return factors[num]


def get_totients(num):
    '''Count the number of values between 1 and num-1 that has the gcd of 1'''
    global totients

    # If we've calculated this before, return the result
    if num not in totients:
        factors = get_factors(num)

        count = 0
        for n in range(1, num):
            # Count this number if it has no common factors (other than 1)
            if not factors.intersection(get_factors(n)):
                count += 1

        # Store the result when we need it again
        totients[num] = count

    return totients[num]


def is_ptn(num):
    '''Return whether this number is a perfect totient number'''

    # Keep a count of the total
    totals = 0

    # Loop until we get to one
    n = num
    while n > 1:
        totient = get_totients(n)
        totals += totient

        if totals > num:
            # Short circuit exit if we know it will be False
            return False

        n = totient

    return totals == num


def main():
    global primes
    solutions = []
    number = 0

    # Loop until we have 20 solutions
    while(len(solutions) < 20):
        number += 1

        if is_prime(number):
            primes.append(number)

        if is_ptn(number):
            solutions.append(number)

    print(*solutions, sep=', ')


if __name__ == '__main__':
    main()
