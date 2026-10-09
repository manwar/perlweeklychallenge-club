#!/usr/bin/env python3
"""Consecutive Sequence - Perl Weekly Challenge 294 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def longest_consecutive_sequence(ints: Sequence[int]) -> int:
    """Find the length of the longest consecutive sequence; return -1 if <= 1."""
    nums = set(ints)
    max_length = 0

    for num in ints:
        # Check if num is the start of a consecutive sequence
        if num - 1 not in nums:
            current_num = num
            current_length = 1

            while current_num + 1 in nums:
                current_num += 1
                current_length += 1

            if current_length > max_length:
                max_length = current_length

    return max_length if max_length > 1 else -1


class TestConsecutiveSequence(unittest.TestCase):
    """Unit tests for longest_consecutive_sequence."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(longest_consecutive_sequence([10, 4, 20, 1, 3, 2]), 4)

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(
            longest_consecutive_sequence([0, 6, 1, 8, 5, 2, 4, 3, 0, 7]), 9
        )

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(longest_consecutive_sequence([10, 30, 20]), -1)

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(longest_consecutive_sequence([1, 9, 3, 10, 4, 20, 2]), 4)

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(longest_consecutive_sequence([5, 6, 1, 2, 3, 4]), 6)

    def test_example6(self) -> None:
        """Test example 6."""
        self.assertEqual(longest_consecutive_sequence([100, 4, 200, 1, 3, 2]), 4)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        ints = [int(x) for x in argv[1:]]
        print(f"Output: {longest_consecutive_sequence(ints)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
