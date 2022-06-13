#!/usr/bin/env python3

def is_achilles_number(num):
    '''Determine if this number is an achilles numbers'''

    # Get the prime factors of the number
    factors = {}

    i = 2
    while num > 1:
        if num % i == 0:
            num /= i
            if i in factors:
                factors[i] += 1
            else:
                factors[i] = 1
        else:
            i += 1

    # If there is only one prime factor, it is not an achilles number
    if len(factors) == 1:
        return False

    # Get a list of unique powers
    powers = set(factors.values())

    # It's also not an achilles number if any of the powers were 1, or the
    #  powers are all the same (a perfect sqaure)
    if 1 in powers or len(powers) == 1:
        return False

    # Finally, the greatest common divisor of these numbers has to be one
    for i in range(2, min(powers)+1):
        if all(x % i == 0 for x in powers):
            return False

    return True


def main():
    '''Find the first 20 achilles numbers'''
    solutions = []
    num = 2

    # Get the first 20 achilles numbers
    while len(solutions) < 20:
        if is_achilles_number(num):
            solutions.append(num)
        num += 1

    # Print the list
    print(*solutions, sep=', ')


if __name__ == '__main__':
    main()
