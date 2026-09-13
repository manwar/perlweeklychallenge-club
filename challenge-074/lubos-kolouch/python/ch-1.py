#!/usr/bin/env python3
"""Perl Weekly Challenge 074 - Task 1: Majority Element.

Find the majority element in the list that appears more than floor(size/2) times.
Return -1 if none found.
"""

from __future__ import annotations

import unittest


def get_majority_element(arr: list[int]) -> int:
    """Return the majority element appearing strictly more than len(arr)//2 times, or -1.

    :param arr: List of integers.
    :return: The majority integer or -1.
    """
    if not arr:
        return -1

    counts: dict[int, int] = {}
    threshold = len(arr) // 2

    for item in arr:
        counts[item] = counts.get(item, 0) + 1
        if counts[item] > threshold:
            return item

    return -1


class TestMajorityElement(unittest.TestCase):
    """Test cases for get_majority_element."""

    def test_example_1(self) -> None:
        self.assertEqual(get_majority_element([1, 2, 2, 3, 2, 4, 2]), 2)

    def test_example_2(self) -> None:
        self.assertEqual(get_majority_element([1, 3, 1, 2, 4, 5]), -1)

    def test_single_element(self) -> None:
        self.assertEqual(get_majority_element([7]), 7)

    def test_empty_list(self) -> None:
        self.assertEqual(get_majority_element([]), -1)


if __name__ == "__main__":
    unittest.main()
