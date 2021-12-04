#!/usr/bin/python3

'''

Week 141:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-141

Task #1: Like Numbers

    You are given positive integers, $m and $n.

    Write a script to find total count of integers created using the digits of $m which is also divisible by $n.

'''

from itertools import combinations
import unittest

def like_numbers(m, n):
    numbers  = []
    m_digits = [int(a) for a in str(m)]

    for i in range(1, len(m_digits)):
        divisors = []
        for j in combinations(m_digits, i):
            num = int(''.join(str(x) for x in (j)))
            if num % n == 0:
                numbers.append(num)

    return numbers

#
#
# Unit test class

class TestJortSort(unittest.TestCase):

    def test_example_1(self):
        self.assertEqual(
            like_numbers(1234, 2),
            [2, 4, 12, 14, 24, 34, 124, 134, 234],
            'Example 1')

    def test_example_2(self):
        self.assertEqual(
            like_numbers(768, 4),
            [8, 76, 68],
            'Example 2')

unittest.main()
