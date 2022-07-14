#!/usr/bin/python3

'''

Week 172:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-172

Task #2: Five-number Summary

    You are given an array of integers.

    Write a script to compute the five-number summary of the given
    set of integers.

'''

import sys
import unittest

def median(n):
    if len(n) % 2 == 1:
        return n[int((len(n)-1)/2)]

    return (n[int(len(n)/2)-1] + n[int(len(n)/2)]) / 2

def five_number_summary(n):
    n = sorted(n)
    _min = n[0]
    _max = n[-1]
    _med = median(n)
    _q1  = median([i for i in n if i < _med])
    _q3  = median([i for i in n if i > _med])

    return [_min, _q1, _med, _q3, _max]

#
#
# Unit test class

class TestFiveNumberSummary(unittest.TestCase):

    def test_example(self):
        self.assertEqual(
            five_number_summary([0,0,1,2,63,61,27,13]),
            [0,0.5,7.5,44,63],
            'Example')

unittest.main()
