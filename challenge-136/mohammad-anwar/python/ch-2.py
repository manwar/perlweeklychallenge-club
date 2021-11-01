#!/usr/bin/python3

'''

Week 136:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-136

Task #2: Fibonacci Sequence

    You are given a positive number $n.

    Write a script to find how many different sequences you can create using Fibonacci numbers where the sum of unique numbers in each sequence are the same as the given number.

'''

import sys
import unittest
from itertools import combinations

#
#
# This is translated from my Perl solution for the same task:
#
# https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-136/mohammad-anwar/perl/ch-2.pl

def fibonacci_series_upto(_sum):
    fibonacci_series = [1, 2]
    while fibonacci_series[-1] + fibonacci_series[-2] <= _sum:
        fibonacci_series.append(fibonacci_series[-1] + fibonacci_series[-2])

    return fibonacci_series

def fibonacci_sequence(_sum):
    fibonacci_series = fibonacci_series_upto(_sum)
    fibonacci_sum    = []

    for i in range(1, _sum):
        if i > len(fibonacci_series):
            break

        for comb in combinations(fibonacci_series, i):
            if sum(comb) == _sum:
                fibonacci_sum.append(comb)

    return len(fibonacci_sum)

#
#
# Unit test class

class TestFibonacciSequence(unittest.TestCase):

    def test_example_1(self):
        self.assertEqual(fibonacci_sequence(16), 4, 'Example 1')

    def test_example_2(self):
        self.assertEqual(fibonacci_sequence(9),  2, 'Example 2')

    def test_example_3(self):
        self.assertEqual(fibonacci_sequence(15), 2, 'Example 3')

unittest.main()
