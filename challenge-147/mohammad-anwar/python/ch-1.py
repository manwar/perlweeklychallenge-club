#!/usr/bin/python3

'''

Week 147:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-147

Task #1: Truncatable Primme

    Write a script to generate first 20 left-truncatable prime numbers in base 10.

'''

import re
import math
import numpy
import unittest

def is_prime(n):
    if (n == 1):
        return False

    i = 2
    while (i <= int(math.sqrt(n))):
        if ((n % i) == 0):
            return False
        i += 1

    return True

def left_truncatable_numbers(n):
    numbers = []
    i = 0
    s = str(n)
    while (i < len(s)):
        numbers.append(int(s[i:]))
        i += 1

    return numbers;

def left_truncatable_primes(count):
    ltp = []
    c   = 0
    n   = 2
    while (c < count):
        containZero = re.search('0', str(n))
        if ((not containZero) and is_prime(n)):
            numbers = left_truncatable_numbers(n)
            found = True
            if (len(numbers) >= 2):
                for i in numbers:
                    if (not is_prime(i)):
                        found = False

            if (found):
                ltp.append(n)
                c += 1

        n += 1

    return ltp

#
#
# Unit test class

class TestTruncatablePrime(unittest.TestCase):

   def test_example(self):
        exp = [2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137, 167, 173, 197]
        got = left_truncatable_primes(20)
        self.assertEqual(numpy.alltrue(exp == got), True, 'Example')

unittest.main()
