#!/usr/bin/python3
# ch-1.py

# > https://theweeklychallenge.org/blog/perl-weekly-challenge-146/
#
# ## Task 1 > 10001st Prime Number
# ================================
#
# Write a script to generate the 10001st prime number.

import math
import sys

###############################################################################
# PWC Solution ################################################################
###############################################################################


def get_prime(nth):
    primes = [2, 3]
    cursor = 5
    while (len(primes) < nth):
        is_prime = True
        for prime in primes:
            if prime > math.sqrt(cursor):
                break
            if cursor % prime == 0:
                is_prime = False
                break
        if is_prime:
            primes.append(cursor)
        cursor += 2
    return primes.pop()


###############################################################################
# Utilities ###################################################################
###############################################################################


def get_suffix(num):
    last_d = num % 10
    if last_d == 0 or last_d >= 4:
        return 'th'
    if last_d == 1:
        return 'st'
    if last_d == 2:
        return 'nd'
    if last_d == 3:
        return 'rd'
    return ''


def print_colors(string, color):
    colordict = {
        'yellow': '\u001b[33m',
        'green': '\u001b[32m',
        'reset': '\u001b[0m'
    }
    return f"{colordict[color]}{string}{colordict['reset']}"


###############################################################################
# Main ########################################################################
###############################################################################

try:
    nth = int(sys.argv[1])
except IndexError:
    nth = 10001

prime = get_prime(nth)
suffix = get_suffix(nth)
num_str = print_colors(str(nth) + suffix, 'yellow')
prime_str = print_colors(prime, 'green')

print(f"The {num_str} prime number is {prime_str}")
