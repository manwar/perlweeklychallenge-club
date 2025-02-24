"""
Module for finding the minimum difference between any two elements in a list.

This module provides the `min_diff` function, which, given a list of integers,
returns the smallest difference between any two elements. To efficiently compute this,
the list is first sorted so that differences only need to be computed for consecutive
elements.

If the list has fewer than two elements, the function returns None.

Examples:
    >>> min_diff([1, 5, 8, 9])
    1
    >>> min_diff([9, 4, 1, 7])
    2

Author: Mohammad Sajid Anwar (Challenge), Modified by Lubos Kolouch.
"""

from typing import Optional

# Type alias for a list of integers
IntList = list[int]


def min_diff(arr: IntList) -> Optional[int]:
    """
    Return the minimum difference between any two elements in the list.

    The function sorts the list and computes differences between consecutive elements,
    which is sufficient to determine the minimum difference.

    :param arr: A list of integers.
    :return: The smallest difference between any two elements, or None if the list has fewer than two elements.
    """
    if len(arr) < 2:
        return None

    # Sort the list to simplify the calculation of differences.
    sorted_arr = sorted(arr)
    # Initialize min_diff using the first consecutive pair.
    min_delta = sorted_arr[1] - sorted_arr[0]

    # Compute differences between adjacent elements.
    for i in range(2, len(sorted_arr)):
        delta = sorted_arr[i] - sorted_arr[i - 1]
        if delta < min_delta:
            min_delta = delta

    return min_delta


if __name__ == '__main__':
    import unittest

    class TestMinDiff(unittest.TestCase):

        def test_example1(self):
            """Example 1: [1, 5, 8, 9] should return 1."""
            self.assertEqual(min_diff([1, 5, 8, 9]), 1)

        def test_example2(self):
            """Example 2: [9, 4, 1, 7] should return 2."""
            self.assertEqual(min_diff([9, 4, 1, 7]), 2)

        def test_empty(self):
            """Test with an empty list should return None."""
            self.assertIsNone(min_diff([]))

        def test_single_element(self):
            """Test with a single element should return None."""
            self.assertIsNone(min_diff([42]))

        def test_duplicates(self):
            """Test with duplicate elements, expecting a difference of 0."""
            self.assertEqual(min_diff([3, 3, 5, 8]), 0)

        def test_all_negative(self):
            """Test with all negative numbers."""
            # For example: [-10, -5, -3, -1] -> differences: 5, 2, 2 -> min diff is 2.
            self.assertEqual(min_diff([-10, -5, -3, -1]), 2)

        def test_mixed(self):
            """Test with a mix of negative and positive numbers."""
            # For example: [-5, 0, 3, 8] -> differences: 5, 3, 5 -> min diff is 3.
            self.assertEqual(min_diff([-5, 0, 3, 8]), 3)

    unittest.main()
