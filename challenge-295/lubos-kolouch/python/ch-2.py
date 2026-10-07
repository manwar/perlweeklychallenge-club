#!/usr/bin/env python3
"""Jump Game - Perl Weekly Challenge 295 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def min_jumps(ints: Sequence[int]) -> int:
    """Calculate the minimum number of jumps to reach the last index."""
    n = len(ints)
    if n <= 1:
        return 0
    if ints[0] == 0:
        return -1

    jumps = 0
    current_end = 0
    farthest = 0

    for i in range(n - 1):
        farthest = max(farthest, i + ints[i])

        if i == current_end:
            jumps += 1
            current_end = farthest

            if current_end >= n - 1:
                return jumps

        if farthest <= i:
            return -1

    return -1


class TestJumpGame(unittest.TestCase):
    """Unit tests for min_jumps."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(min_jumps([2, 3, 1, 1, 4]), 2)

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(min_jumps([2, 3, 0, 4]), 2)

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(min_jumps([2, 0, 0, 4]), -1)

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(min_jumps([1, 1, 1, 1]), 3)

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(min_jumps([0]), 0)

    def test_example6(self) -> None:
        """Test example 6."""
        self.assertEqual(min_jumps([1, 0, 1, 0]), -1)

    def test_example7(self) -> None:
        """Test example 7."""
        self.assertEqual(min_jumps([2, 1]), 1)

    def test_example8(self) -> None:
        """Test example 8."""
        self.assertEqual(min_jumps([1, 2, 3]), 2)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        ints = [int(x) for x in argv[1:]]
        print(f"Output: {min_jumps(ints)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
