#!/usr/bin/python3

'''

Week 174:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-174

Task #1: Disarium Numbers

    Write a script to generate first 19 Disarium Numbers.

'''

import unittest

def is_disarium_number(n):
    _str = str(n)
    _sum = 0
    for i in range(0, len(_str)):
        _sum += int(_str[i]) ** (i + 1)

    return _sum == n

def disarium_numbers(n):
    i  = 0
    dn = []
    while len(dn) < n:
        if is_disarium_number(i):
            dn.append(i)
        i = i + 1

    return dn

#
#
# Unit test class

class TestDisariumNumbers(unittest.TestCase):
    def test_example(self):
        exp = [ 0,1,2,3,4,5,6,7,8,9,89,135,175,518,598,1306,1676,2427,2646798 ]
        got = disarium_numbers(19)
        self.assertEqual(exp, got)

unittest.main()
