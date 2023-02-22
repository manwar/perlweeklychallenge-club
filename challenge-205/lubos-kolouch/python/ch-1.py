#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
from typing import List


def find_third_highest(array: List[int]) -> int:
    """
    Finds the third highest number in an array of integers.

    If the array has fewer than three distinct values, returns the maximum value.

    Args:
        array: List of integers to search.

    Returns:
        Third highest distinct integer, or maximum integer if there are fewer than three distinct values.
    """

    distinct_numbers = set(array)
    if len(distinct_numbers) < 3:
        return max(array)
    else:
        # Sort distinct numbers in descending order
        sorted_numbers = sorted(distinct_numbers, reverse=True)
        return sorted_numbers[2]


class TestFindThirdHighest(unittest.TestCase):
    def test_example1(self):
        array = [5, 3, 4]
        self.assertEqual(find_third_highest(array), 3)

    def test_example2(self):
        array = [5, 6]
        self.assertEqual(find_third_highest(array), 6)

    def test_example3(self):
        array = [5, 4, 4, 3]
        self.assertEqual(find_third_highest(array), 3)

    def test_all_same(self):
        array = [2, 2, 2, 2]
        self.assertEqual(find_third_highest(array), 2)

    def test_negative_numbers(self):
        array = [1, -5, 3, -5, 2]
        self.assertEqual(find_third_highest(array), 1)


if __name__ == "__main__":
    unittest.main()
