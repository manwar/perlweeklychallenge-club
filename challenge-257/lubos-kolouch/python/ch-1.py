#!/usr/bin/env python3
"""Smaller than Current - Perl Weekly Challenge 257 task 1."""

from __future__ import annotations

import unittest


def smaller_than_current(ints: list[int] | tuple[int, ...]) -> list[int]:
    """Return for each element the count of elements strictly smaller than it."""
    return [sum(x < y for x in ints) for y in ints]


class TestSmallerThanCurrent(unittest.TestCase):
    """Unit tests for smaller_than_current."""

    def test_example_1(self) -> None:
        """Verify Example 1."""
        self.assertEqual(smaller_than_current([5, 2, 1, 6]), [2, 1, 0, 3])

    def test_example_2(self) -> None:
        """Verify Example 2."""
        self.assertEqual(smaller_than_current([1, 2, 0, 3]), [1, 2, 0, 3])

    def test_example_3(self) -> None:
        """Verify Example 3."""
        self.assertEqual(smaller_than_current([0, 1]), [0, 1])

    def test_example_4(self) -> None:
        """Verify Example 4."""
        self.assertEqual(smaller_than_current([9, 4, 9, 2]), [2, 1, 2, 0])


if __name__ == "__main__":
    unittest.main()
