#!/usr/bin/python3

'''

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #2: Total Zero

    You are given two positive integers $x and $y.

    Write a script to find out the number of operations needed to
    make both ZERO. Each operator is made up either of the following:

        $x = $x - $y if $x >= $y

        or

        $y = $y - $x if $y >= $x

'''

import unittest

def totalZero(x, y) -> int:
    count = 0
    while x > 0 and y > 0:
        if x >= y:
            x = x - y
        else:
            y = y - x

        count = count + 1

    return count

#
#
# Unit test class

class TestTotalZero(unittest.TestCase):
    def test_TotalZero(self):
        self.assertEqual(totalZero(5, 4), 5, 'Example 1')
        self.assertEqual(totalZero(4, 6), 3, 'Example 2')
        self.assertEqual(totalZero(2, 5), 4, 'Example 3')
        self.assertEqual(totalZero(3, 1), 3, 'Example 4')
        self.assertEqual(totalZero(7, 4), 5, 'Example 5')

unittest.main()
