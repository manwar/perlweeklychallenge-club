#!/usr/bin/python3

'''

Week 188:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #1: Divisible Pairs

    You are given list of integers @list of size $n and divisor $k.

    Write a script to find out count of pairs in the given list that
    satisfies the following rules.

    The pair (i, j) is eligible if and only if
    a) 0 <= i < j < len(list)
    b) list[i] + list[j] is divisible by k

'''

import unittest

def countDivisiblePairs(array, k) -> int:
    count = 0
    size  = len(array)
    for i in range(size):
        for j in range(i + 1, size):
            if (array[i] + array[j]) % k == 0:
                count = count + 1

    return count

#
#
# Unit test class

class TestDivisiblePairs(unittest.TestCase):
    def test_divisiblePairs(self):
        self.assertEqual(countDivisiblePairs([4, 5, 1, 6], 2), 2, 'Example 1')
        self.assertEqual(countDivisiblePairs([1, 2, 3, 4], 2), 2, 'Example 2')
        self.assertEqual(countDivisiblePairs([1, 3, 4, 5], 3), 2, 'Example 3')
        self.assertEqual(countDivisiblePairs([5, 1, 2, 3], 4), 2, 'Example 4')
        self.assertEqual(countDivisiblePairs([7, 2, 4, 5], 4), 1, 'Example 5')

unittest.main()
