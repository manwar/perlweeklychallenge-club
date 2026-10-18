#!/usr/bin/env python3
"""Middle Index - Perl Weekly Challenge 291 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def find_middle_index(ints: Sequence[int]) -> int:
    """Find the leftmost index where the sum of left elements equals sum of right elements."""
    total_sum = sum(ints)
    left_sum = 0

    for i, val in enumerate(ints):
        right_sum = total_sum - left_sum - val

        if left_sum == right_sum:
            return i

        left_sum += val

    return -1


class TestMiddleIndex(unittest.TestCase):
    """Unit tests for find_middle_index."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(find_middle_index([2, 3, -1, 8, 4]), 3)

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(find_middle_index([1, -1, 4]), 2)

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(find_middle_index([2, 5]), -1)

    def test_single_element(self) -> None:
        """Test single element."""
        self.assertEqual(find_middle_index([0]), 0)

    def test_empty(self) -> None:
        """Test empty sequence."""
        self.assertEqual(find_middle_index([]), -1)

    def test_zeros(self) -> None:
        """Test sequence with zero."""
        self.assertEqual(find_middle_index([0, 1, -1]), 0)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        ints = [int(x) for x in argv[1:]]
        print(f"Output: {find_middle_index(ints)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
