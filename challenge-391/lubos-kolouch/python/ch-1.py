#!/usr/bin/env python3
"""Perl Weekly Challenge 391 - Task 1: Median of Arrays.

Merge two sorted arrays and return the median of the merged array.
"""

from __future__ import annotations

import unittest


def find_median_sorted_arrays(arr1: list[int], arr2: list[int]) -> float:
    """Merge two sorted integer arrays and compute their median.

    :param arr1: First sorted list of integers.
    :param arr2: Second sorted list of integers.
    :return: Median of the combined elements as a float.
    """
    merged: list[int] = []
    i = 0
    j = 0
    n = len(arr1)
    m = len(arr2)

    while i < n and j < m:
        if arr1[i] <= arr2[j]:
            merged.append(arr1[i])
            i += 1
        else:
            merged.append(arr2[j])
            j += 1

    merged.extend(arr1[i:])
    merged.extend(arr2[j:])

    total = len(merged)
    if total == 0:
        raise ValueError("Both input arrays are empty.")

    if total % 2 == 1:
        return float(merged[total // 2])

    mid = total // 2
    return (merged[mid - 1] + merged[mid]) / 2.0


class TestMedianSortedArrays(unittest.TestCase):
    """Test cases for find_median_sorted_arrays."""

    def test_example_1(self) -> None:
        self.assertEqual(find_median_sorted_arrays([2], [4]), 3.0)

    def test_example_2(self) -> None:
        self.assertEqual(find_median_sorted_arrays([1, 2, 3], [7, 8, 9, 10]), 7.0)

    def test_example_3(self) -> None:
        self.assertEqual(find_median_sorted_arrays([], [10, 20, 30, 40]), 25.0)

    def test_example_4(self) -> None:
        self.assertEqual(find_median_sorted_arrays([100], [1, 2, 3, 4, 5, 6, 7]), 4.5)

    def test_example_5(self) -> None:
        self.assertEqual(find_median_sorted_arrays([1, 2, 2], [2, 2, 3]), 2.0)


if __name__ == "__main__":
    unittest.main()
