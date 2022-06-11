#!/usr/bin/python3

'''

Week 150:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-150

Task #1: Fibonacci Words

    You are given two strings having same number of digits, $a and $b.

    Write a script to generate Fibonacci Words by concatenation of the previous two strings. Finally print 51st digit of the first term having at least 51 digits.

'''

import unittest

def fibonacci_words(term1, term2, index):
    while (len(term1 + term2) <= index):
        term1, term2 = term2, term1 + term2

    return (term1 + term2)[index-1]

#
#
# Unit test class

class TestTruncatablePrime(unittest.TestCase):

   def test_example(self):
        self.assertEqual(fibonacci_words('1234', '5678', 51), '7', 'Example')

unittest.main()
