#!/usr/bin/env python3

import re


def is_odd_number(num):
    '''Returns True if all numbers are odd'''
    return True if re.search('^[13579]+$', str(num)) else False


def reverse_number(num):
    '''Very crude method to reverse a number'''
    return int(str(num)[::-1])


def main():
    solutions = []
    # Go from 1 to 99.
    for num in range(1, 100):
        # If the sum of the number and the reversed number is all odd...
        if is_odd_number(num + reverse_number(num)):
            # Add it to the list
            solutions.append(num)

    print(*solutions, sep=', ')


if __name__ == '__main__':
    main()
