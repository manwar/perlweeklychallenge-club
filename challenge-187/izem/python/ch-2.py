"""Perl weekly challenge 187 - Task #2: Magical Triplets.

You are given a list of positive numbers, @n, having at least 3 numbers.
Write a script to find the triplets (a, b, c) from the given list that
satisfies the following rules
i.e. 'a + b > c', 'b + c > a', 'a + c > b' and 'a + b + c' is maximum.
In case, you end up with more than one triplets having the maximum then
pick the triplet where 'a >= b >= c'.

https://theweeklychallenge.org/blog/perl-weekly-challenge-187/#TASK2
"""
import unittest
from typing import Iterable


def magical_triplets(numbers: Iterable[int]) -> Iterable | None:
    """Return most magical triplet from given numbers.

    :param numbers: numbers to make triplets (at least 3)
    :return: most magical triplet (or empty)
    """
    if len(numbers) < 3:
        raise ValueError("Input list should be at least 3 numbers.")

    triplet = (0,)
    for i, a in enumerate(numbers):
        for j, b in enumerate(numbers):
            if j == i:
                continue
            for k, c in enumerate(numbers):
                if k == i or k == j:
                    continue
                if a + b > c and b + c > a and a + c > b \
                        and sum((a, b, c)) >= sum(triplet):
                    if sum((a, b, c)) == sum(triplet) and not a >= b >= c:
                        continue
                    triplet = (a, b, c)

    return triplet if len(triplet) == 3 else None


class TestMagicalTriplets(unittest.TestCase):

    def test_magical_triplets(self):
        cases = (
            ((1, 2, 3, 2), (3, 2, 2)),
            ((1, 3, 2), None),
            ((1, 1, 2, 3), None),
            ((2, 4, 3), (4, 3, 2)),
        )
        for case in cases:
            self.assertEqual(magical_triplets(case[0]), case[1], f"Input: {case[0]}")


if __name__ == '__main__':
    unittest.main()
