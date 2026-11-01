#!/usr/bin/env python3
"""Lucky Integer - The Weekly Challenge 284 Task 1."""

from __future__ import annotations

from collections import Counter
from collections.abc import Sequence
import sys
import unittest


def find_lucky_integer(ints: list[int]) -> int:
    """Find the lucky integer in the given list of integers.

    A lucky integer is an integer whose frequency in the array is equal to its value.
    If there are multiple lucky integers, returns the largest one.
    If no lucky integers are found, returns -1.

    Args:
        ints: A list of integers.

    Returns:
        The largest lucky integer if found, otherwise -1.
    """
    freq = Counter(ints)
    lucky_integers = [num for num, count in freq.items() if num == count]
    if lucky_integers:
        return max(lucky_integers)
    return -1


class TestFindLuckyInteger(unittest.TestCase):
    """Unit tests for find_lucky_integer."""

    def test_example1(self) -> None:
        """Test Example 1: [2, 2, 3, 4] -> 2."""
        self.assertEqual(find_lucky_integer([2, 2, 3, 4]), 2)

    def test_example2(self) -> None:
        """Test Example 2: [1, 2, 2, 3, 3, 3] -> 3."""
        self.assertEqual(find_lucky_integer([1, 2, 2, 3, 3, 3]), 3)

    def test_example3(self) -> None:
        """Test Example 3: [1, 1, 1, 3] -> -1."""
        self.assertEqual(find_lucky_integer([1, 1, 1, 3]), -1)

    def test_additional(self) -> None:
        """Test additional edge cases."""
        self.assertEqual(find_lucky_integer([5, 5, 5, 5, 5]), 5)
        self.assertEqual(find_lucky_integer([2, 2, 2, 3, 3]), -1)
        self.assertEqual(find_lucky_integer([]), -1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        nums = [int(x) for x in argv[1:]]
        print(f"Output: {find_lucky_integer(nums)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
