#!/usr/bin/env python3
"""
Perl Weekly Challenge 073 - Task 2: Smallest Neighbour

You are given an array of integers @A.
Write a script to create an array that represents the smallest element
to the left of each corresponding index. If none found, then use 0.
"""

import unittest


def get_smallest(arr: list[int]) -> list[int]:
    """Return smallest element to the left of each index, or 0 if none is smaller."""
    if not arr:
        return []

    result: list[int] = [0]
    current_min = arr[0]

    for x in arr[1:]:
        if current_min < x:
            result.append(current_min)
        else:
            result.append(0)

        if x < current_min:
            current_min = x

    return result


class TestSmallestNeighbour(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(get_smallest([7, 8, 3, 12, 10]), [0, 7, 0, 3, 3])

    def test_example_2(self) -> None:
        self.assertEqual(get_smallest([4, 6, 5]), [0, 4, 4])

    def test_single_element(self) -> None:
        self.assertEqual(get_smallest([5]), [0])

    def test_empty(self) -> None:
        self.assertEqual(get_smallest([]), [])


if __name__ == "__main__":
    unittest.main()

