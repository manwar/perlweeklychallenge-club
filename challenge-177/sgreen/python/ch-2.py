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


def cyclops_number(number):
    '''Given a number return an integer of that number, a zero and the number in reverse'''
    s = str(number)
    return int(s + '0' + s[::-1])

def main():
    solutions = []
    number = 1
    while len(solutions) < 20:
        cn = cyclops_number(number)
        if '0' not in str(number) and is_prime(cn):
            solutions.append(cn)

        number+=1

    print (*solutions, sep=', ')

if __name__ == '__main__':
    main()