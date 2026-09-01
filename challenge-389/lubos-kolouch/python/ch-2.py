#!/usr/bin/env python3
"""Perl Weekly Challenge 389 - Task 2: ZigZag Subarray.

Find the length of the longest contiguous subarray where the numbers
alternate between strictly increasing and strictly decreasing.
"""

from __future__ import annotations

import unittest


def longest_zigzag_subarray(nums: list[int]) -> int:
    """Return the length of the longest contiguous ZigZag subarray.

    :param nums: List of integers.
    :return: Length of the longest ZigZag subarray.
    """
    n = len(nums)
    if n == 0:
        return 0
    if n == 1:
        return 1

    max_len = 1
    curr_len = 1
    last_diff = 0

    for i in range(1, n):
        if nums[i] > nums[i - 1]:
            diff = 1
        elif nums[i] < nums[i - 1]:
            diff = -1
        else:
            diff = 0

        if diff == 0:
            curr_len = 1
            last_diff = 0
        elif last_diff == 0 or diff == -last_diff:
            curr_len += 1
            last_diff = diff
        else:
            # Same direction twice in a row (e.g. up-up or down-down)
            curr_len = 2
            last_diff = diff

        if curr_len > max_len:
            max_len = curr_len

    return max_len


class TestLongestZigzagSubarray(unittest.TestCase):
    """Test cases for longest_zigzag_subarray."""

    def test_example_1(self) -> None:
        self.assertEqual(longest_zigzag_subarray([9, 4, 2, 10, 7, 8, 8, 1, 9]), 5)

    def test_example_2(self) -> None:
        self.assertEqual(longest_zigzag_subarray([1, 7, 4, 9, 2, 5]), 6)

    def test_example_3(self) -> None:
        self.assertEqual(longest_zigzag_subarray([1, 2, 3, 4, 5]), 2)

    def test_example_4(self) -> None:
        self.assertEqual(longest_zigzag_subarray([4, 4, 4]), 1)

    def test_example_5(self) -> None:
        self.assertEqual(longest_zigzag_subarray([10, 20, 15, 12, 18]), 3)

    def test_single_element(self) -> None:
        self.assertEqual(longest_zigzag_subarray([5]), 1)

    def test_empty_array(self) -> None:
        self.assertEqual(longest_zigzag_subarray([]), 0)

    def test_two_equal(self) -> None:
        self.assertEqual(longest_zigzag_subarray([5, 5]), 1)


if __name__ == "__main__":
    unittest.main()
