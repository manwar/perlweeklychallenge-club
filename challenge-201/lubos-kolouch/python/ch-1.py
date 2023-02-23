#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List
import unittest


def find_missing_numbers(arr: List[int]) -> List[int]:
    """
    Find all missing numbers in the range 0..n where n is the array size.
    Args:
        arr: A list of unique integers.
    Returns:
        A list of missing integers in the range 0..n where n is the array size.
    """
    n = len(arr)
    s = set(arr)
    missing_numbers = []
    for i in range(n + 1):
        if i not in s:
            missing_numbers.append(i)
    return missing_numbers


# test cases
class TestMissingNumbers(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(find_missing_numbers([0, 1, 3]), [2])

    def test_example2(self):
        self.assertEqual(find_missing_numbers([0, 1]), [2])


if __name__ == '__main__':
    unittest.main()
