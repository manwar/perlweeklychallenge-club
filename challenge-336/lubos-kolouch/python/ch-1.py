#!/usr/bin/env python3
"""The Weekly Challenge 336 Task 1: Equal Group."""
from collections import Counter
from math import gcd
import unittest

IntList = list[int]


def equal_group(ints: IntList) -> bool:
    """Return True if values can be partitioned into equal homogeneous groups."""
    if len(ints) < 2:
        return False

    counts = Counter(ints)
    if any(count < 2 for count in counts.values()):
        return False

    group_size = 0
    for count in counts.values():
        group_size = gcd(group_size, count)
    return group_size >= 2


class TestEqualGroup(unittest.TestCase):
    """Unit tests using the provided examples."""

    def test_example1(self) -> None:
        self.assertTrue(equal_group([1, 1, 2, 2, 2, 2]))

    def test_example2(self) -> None:
        self.assertFalse(equal_group([1, 1, 1, 2, 2, 2, 3, 3]))

    def test_example3(self) -> None:
        self.assertTrue(equal_group([5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7]))

    def test_example4(self) -> None:
        self.assertFalse(equal_group([1, 2, 3, 4]))

    def test_example5(self) -> None:
        self.assertTrue(equal_group([8, 8, 9, 9, 10, 10, 11, 11]))


if __name__ == "__main__":
    unittest.main()
