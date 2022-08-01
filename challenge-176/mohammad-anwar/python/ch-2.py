#!/usr/bin/python3

'''

Week 176:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-176

Task 2: Reversible Numbers

    Write a script to find out all Reversible Numbers below 100.

'''

import unittest

def hasAllOddDigits(n) -> bool:
    digits = [int(a) for a in str(n)]
    for i in digits:
        if i % 2 == 0:
            return False

    return True

def allReversibleNumbersBelow(n):
    rn = []
    for i in range(1, n+1):
        if hasAllOddDigits(i + int(str(i)[::-1])):
            rn.append(i)

    return rn

#
#
# Unit test class

class TestReversibleNumbers(unittest.TestCase):
    def test_ReversibleNumbers(self):
        exp = [
            10, 12, 14, 16, 18, 21, 23, 25, 27,
            30, 32, 34, 36, 41, 43, 45, 50, 52,
            54, 61, 63, 70, 72, 81, 90
        ]
        self.assertEqual(exp, allReversibleNumbersBelow(100))

unittest.main()
