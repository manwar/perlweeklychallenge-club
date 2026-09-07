#!/usr/bin/env python3
"""
Perl Weekly Challenge 071 - Task 1: Peak Elements

Write a script that prints all the peak elements in the given array.
A peak element is an element that is greater than its neighbours.
"""

import unittest


def find_peaks(arr: list[int]) -> list[int]:
    """Find all peak elements in the array."""
    n = len(arr)
    if n == 0:
        return []
    if n == 1:
        return [arr[0]]

    peaks: list[int] = []

    # First element
    if arr[0] > arr[1]:
        peaks.append(arr[0])

    # Middle elements
    for i in range(1, n - 1):
        if arr[i] > arr[i - 1] and arr[i] > arr[i + 1]:
            peaks.append(arr[i])

    # Last element
    if arr[-1] > arr[-2]:
        peaks.append(arr[-1])

    return peaks


class TestFindPeaks(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(
            find_peaks([18, 45, 38, 25, 10, 7, 21, 6, 28, 48]),
            [45, 21, 48],
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            find_peaks([47, 11, 32, 8, 1, 9, 39, 14, 36, 23]),
            [47, 32, 39, 36],
        )

    def test_single_element(self) -> None:
        self.assertEqual(find_peaks([5]), [5])


if __name__ == "__main__":
    unittest.main()
