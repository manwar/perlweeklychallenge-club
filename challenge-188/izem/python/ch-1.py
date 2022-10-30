"""Perl weekly challenge 188 - Task 1: Divisible Pairs

You are given list of integers @list of size $n and divisor $k.
Write a script to find out count of pairs in the given list that satisfies
the rules i.e The pair (i, j) is eligible if and only if
  0 <= i < j < len(list)
  and
  list[i] + list[j] is divisible by k

https://theweeklychallenge.org/blog/perl-weekly-challenge-188/
"""
import unittest
from typing import Iterable, Sized


def divisible_pairs(integers: [Sized, Iterable], divisor: int) -> int:
    """Count pairs in given list that their sum has the given divisor.

    :param integers: list of integers
    :param divisor: the divisor
    :return: pairs count
    """
    pairs = 0
    for i in range(len(integers) - 1):
        for j in range(i + 1, len(integers)):
            if (integers[i] + integers[j]) % divisor == 0:
                pairs += 1
    return pairs


class TestDivisiblePairs(unittest.TestCase):

    def test_divisible_pairs(self):
        cases = (
            {'args': ((4, 5, 1, 6), 2), 'expected': 2},
            {'args': ((1, 2, 3, 4), 2), 'expected': 2},
            {'args': ((1, 3, 4, 5), 3), 'expected': 2},
            {'args': ((5, 1, 2, 3), 4), 'expected': 2},
            {'args': ((7, 2, 4, 5), 4), 'expected': 1},
        )
        for case in cases:
            self.assertEqual(divisible_pairs(*case['args']), case['expected'], str(case['args']))


if __name__ == '__main__':
    unittest.main()
