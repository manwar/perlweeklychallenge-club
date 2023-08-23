#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List, Union
import unittest


def find_neither_min_max(ints: List[int]) -> Union[List[int], int]:
    """
    Returns a list of integers that are not the minimum or maximum values
     in the input list.
    If there are no such values, returns -1.

    Args:
    - ints: A list of integers.

    Returns:
    - A list of integers that are not the minimum or maximum values
       in the input list.
    - If there are no such values, returns -1.
    """
    min_val, max_val = ints[0], ints[0]
    for num in ints:
        if num < min_val:
            min_val = num
        elif num > max_val:
            max_val = num
    result = [num for num in ints if num not in (min_val, max_val)]
    return result if result else -1


class TestFindNeitherMinMax(unittest.TestCase):
    """
    A class for testing the find_neither_min_max function.
    """

    def test_example1(self):
        """
        Test case for example 1.
        """
        self.assertEqual(find_neither_min_max([3, 2, 1, 4]), [3, 2])

    def test_example2(self):
        """
        Test case for example 2.
        """
        self.assertEqual(find_neither_min_max([3, 1]), -1)

    def test_example3(self):
        """
        Test case for example 3.
        """
        self.assertEqual(find_neither_min_max([2, 1, 3]), [2])


if __name__ == "__main__":
    unittest.main()
