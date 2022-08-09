#!/usr/bin/python3

'''

Week 177:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-177

Task #1: Damm Algorigthm

    You are given a positive number, $n.

    Write a script to validate the given number against the included
    check digit.

'''

import unittest

def isValidCheckDigit(num) -> bool:
    op_table = (
        (0, 3, 1, 7, 5, 9, 8, 6, 4, 2),
        (7, 0, 9, 2, 1, 5, 4, 8, 6, 3),
        (4, 2, 0, 6, 8, 7, 1, 3, 5, 9),
        (1, 7, 5, 0, 9, 8, 3, 4, 2, 6),
        (6, 1, 2, 3, 0, 4, 5, 9, 7, 8),
        (3, 6, 7, 4, 2, 0, 9, 5, 8, 1),
        (5, 8, 6, 9, 7, 2, 0, 1, 3, 4),
        (8, 9, 4, 5, 3, 6, 2, 0, 1, 7),
        (9, 4, 3, 8, 6, 1, 7, 2, 0, 5),
        (2, 5, 8, 1, 4, 3, 6, 7, 9, 0)
    )
    n = [int(a) for a in str(num)]
    c = n.pop()
    i = 0
    for j in n:
    	i = op_table[i][j]

    return c == i

#
#
# Unit test class

class TestDammAlgorithm(unittest.TestCase):
    def test_DammAlgorithm(self):
        self.assertTrue(isValidCheckDigit(5724))
        self.assertFalse(isValidCheckDigit(5727))

unittest.main()
