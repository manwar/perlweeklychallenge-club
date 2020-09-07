#!/usr/bin/env python
""" Perl weekly challenge 076 """
# ===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-076/
#
#              Task 1 - Prime Sum
#
#       AUTHOR: Lubos Kolouch
# ===============================================================================
from sympy import isprime


def get_nr_primes(what):
    """ Calculate and return the number of primes needed """

    # if the number is prime, we need just 1 number to represent it

    if isprime(what):
        return 1

    # if the number is even, we need 2 primes thanks to Goldbach's conjecture
    if what % 2 == 1:
        return 2

    # if the number - 2 is prime, return 2
    if isprime(what - 2):
        return 2

    # if the number -3 is prime, return 2 (3 and the prime)
    if isprime(what - 3):
        return 2

    # otherwise return 3 - it is 3 and 2 primes forming $what - 3 thanks to
    # Goldbach's conjecture
    return 3


assert get_nr_primes(2) == 1
assert get_nr_primes(9) == 2
assert get_nr_primes(10) == 2
assert get_nr_primes(12) == 3
