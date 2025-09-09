#!/usr/bin/env python3
"""
Perl Weekly Challenge 334, Task 1: Range Sum

Given a list of integers and two indices, return the sum of integers between the given indices (inclusive).

Args:
    ints (List[int]): List of integers
    x (int): Starting index
    y (int): Ending index

Returns:
    int: Sum of elements between indices x and y
"""

import unittest


def range_sum(ints: list[int], x: int, y: int) -> int:
    # Input validation
    if not ints or x > y or x < 0 or y >= len(ints):
        return 0

    return sum(ints[x:y + 1])


class TestRangeSum(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(range_sum([-2, 0, 3, -5, 2, -1], 0, 2), 1)

    def test_example2(self):
        self.assertEqual(range_sum([1, -2, 3, -4, 5], 1, 3), -3)

    def test_example3(self):
        self.assertEqual(range_sum([1, 0, 2, -1, 3], 3, 4), 2)

    def test_example4(self):
        self.assertEqual(range_sum([-5, 4, -3, 2, -1, 0], 0, 3), -2)

    def test_example5(self):
        self.assertEqual(range_sum([-1, 0, 2, -3, -2, 1], 0, 2), 1)


if __name__ == '__main__':
    unittest.main()
