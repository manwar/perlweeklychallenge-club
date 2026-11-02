#!/usr/bin/env python3
"""Distribute Elements - Perl Weekly Challenge 269 Task 2."""

from __future__ import annotations

import unittest


def distribute_elements(ints: list[int]) -> list[int]:
    """Distribute elements into two lists according to last element comparisons.

    1. Move ints[0] to arr1.
    2. Move ints[1] to arr2.
    3. For remaining elements, if arr1[-1] > arr2[-1], append to arr1;
       otherwise append to arr2.
    4. Return arr1 + arr2.
    """
    if len(ints) <= 1:
        return list(ints)

    arr1: list[int] = [ints[0]]
    arr2: list[int] = [ints[1]]

    for elem in ints[2:]:
        if arr1[-1] > arr2[-1]:
            arr1.append(elem)
        else:
            arr2.append(elem)

    return arr1 + arr2


class TestDistributeElements(unittest.TestCase):
    """Unit tests for distribute_elements."""

    def test_example_1(self) -> None:
        """Test Example 1 from challenge description."""
        self.assertEqual(distribute_elements([2, 1, 3, 4, 5]), [2, 3, 4, 5, 1])

    def test_example_2(self) -> None:
        """Test Example 2 from challenge description."""
        self.assertEqual(distribute_elements([3, 2, 4]), [3, 4, 2])

    def test_example_3(self) -> None:
        """Test Example 3 from challenge description."""
        self.assertEqual(distribute_elements([5, 4, 3, 8]), [5, 3, 4, 8])

    def test_two_elements(self) -> None:
        """Test distribution with exactly two elements."""
        self.assertEqual(distribute_elements([10, 20]), [10, 20])


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
