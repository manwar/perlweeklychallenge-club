#!/usr/bin/env python3
"""
Perl Weekly Challenge 073 - Task 1: Min Sliding Window

You are given an array of integers @A and sliding window size $S.
Write a script to create an array of min from each sliding window.
"""

import unittest


def min_window(arr: list[int], s: int) -> list[int]:
    """Calculate the minimum value for each sliding window of size s."""
    if not arr or s <= 0:
        return []
    if s >= len(arr):
        return [min(arr)]

    return [min(arr[i : i + s]) for i in range(len(arr) - s + 1)]


class TestMinWindow(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(
            min_window([1, 5, 0, 2, 9, 3, 7, 6, 4, 8], 3),
            [0, 0, 0, 2, 3, 3, 4, 4],
        )

    def test_window_larger_than_array(self) -> None:
        self.assertEqual(min_window([1, 2, 3], 4), [1])

    def test_window_size_one(self) -> None:
        self.assertEqual(min_window([3, 1, 2], 1), [3, 1, 2])

    def test_empty_array(self) -> None:
        self.assertEqual(min_window([], 3), [])


if __name__ == "__main__":
    unittest.main()

