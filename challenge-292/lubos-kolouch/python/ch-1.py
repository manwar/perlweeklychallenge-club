#!/usr/bin/env python3
"""Twice Largest - Perl Weekly Challenge 292 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def twice_largest_index(ints: Sequence[int]) -> int:
    """Return index of largest element if at least twice as big as all other elements, else -1."""
    if not ints:
        return -1

    max_value = max(ints)
    max_index = ints.index(max_value)

    for i, val in enumerate(ints):
        if i != max_index and max_value < 2 * val:
            return -1
    return max_index


class TestTwiceLargestIndex(unittest.TestCase):
    """Unit tests for twice_largest_index."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(twice_largest_index([2, 4, 1, 0]), 1)

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(twice_largest_index([1, 2, 3, 4]), -1)

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(twice_largest_index([5, 1, 2, 3]), -1)

    def test_example4(self) -> None:
        """Test single element."""
        self.assertEqual(twice_largest_index([1]), 0)

    def test_example5(self) -> None:
        """Test zeros and one."""
        self.assertEqual(twice_largest_index([0, 0, 0, 1]), 3)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        ints = [int(x) for x in argv[1:]]
        print(f"Output: {twice_largest_index(ints)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
