#!/usr/bin/env python3
"""Third Distinct Maximum - The Weekly Challenge 289 Task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def third_distinct_maximum(ints: Sequence[int]) -> int:
    """Find the third distinct maximum number in the given sequence of integers.

    If the third maximum does not exist, returns the maximum number.

    Args:
        ints: A sequence of integers.

    Returns:
        The third distinct maximum if it exists, otherwise the maximum number.
    """
    distinct_ints = sorted(set(ints), reverse=True)
    if len(distinct_ints) >= 3:
        return distinct_ints[2]
    return distinct_ints[0]


class TestThirdDistinctMaximum(unittest.TestCase):
    """Unit tests for third_distinct_maximum."""

    def test_example1(self) -> None:
        """Test with [5, 6, 4, 1] expecting 4."""
        self.assertEqual(third_distinct_maximum([5, 6, 4, 1]), 4)

    def test_example2(self) -> None:
        """Test with [4, 5] expecting 5."""
        self.assertEqual(third_distinct_maximum([4, 5]), 5)

    def test_example3(self) -> None:
        """Test with [1, 2, 2, 3] expecting 1."""
        self.assertEqual(third_distinct_maximum([1, 2, 2, 3]), 1)

    def test_with_duplicates(self) -> None:
        """Test with duplicates."""
        self.assertEqual(third_distinct_maximum([2, 2, 3, 1]), 1)

    def test_negative_numbers(self) -> None:
        """Test with negative numbers."""
        self.assertEqual(third_distinct_maximum([-1, -2, -3, -4]), -3)

    def test_all_same(self) -> None:
        """Test with all identical numbers."""
        self.assertEqual(third_distinct_maximum([1, 1, 1]), 1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        ints = [int(x) for x in argv[1:]]
        print(f"Output: {third_distinct_maximum(ints)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
