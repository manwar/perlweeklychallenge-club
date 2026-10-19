#!/usr/bin/env python3
"""Finishing Order - Perl Weekly Challenge 396 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def finishing_order(order: Sequence[int], friends: Sequence[int]) -> list[int]:
    """Return the list of friend IDs in race finishing order."""
    friends_set = set(friends)
    return [participant for participant in order if participant in friends_set]


class TestFinishingOrder(unittest.TestCase):
    """Unit tests for finishing_order."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(finishing_order([3, 1, 4, 2, 5], [1, 2, 4]), [1, 4, 2])

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(finishing_order([5, 4, 3, 2, 1], [1, 3, 5]), [5, 3, 1])

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(finishing_order([2, 4, 1, 3], [1, 2, 3, 4]), [2, 4, 1, 3])

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(finishing_order([4, 1, 3, 2], [3]), [3])

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(finishing_order([1, 3, 2, 6, 5, 4], [1, 2, 3]), [1, 3, 2])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    _ = argv
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
