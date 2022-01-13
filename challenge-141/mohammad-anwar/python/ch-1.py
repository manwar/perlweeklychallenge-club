#!/usr/bin/python3

'''

Week 141:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-141

Task #1: Number Divisors

    Write a script to find lowest 10 positive integers having exactly 8 divisors.

'''

import unittest

def number_divisors(count, number):
    numbers = []
    i = 1

    while len(numbers) < count:
        divisors = []
        for j in range(1, i+1):
            if i % j == 0:
                divisors.append(j)

        if len(divisors) == number:
            numbers.append(i)

        i += 1

    return numbers

#
#
# Unit test class

class TestJortSort(unittest.TestCase):

    def test_example_1(self):
        self.assertEqual(
            number_divisors(10, 8),
            [24, 30, 40, 42, 54, 56, 66, 70, 78, 88],
            'Example 1')

unittest.main()
