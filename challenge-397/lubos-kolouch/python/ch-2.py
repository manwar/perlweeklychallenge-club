#!/usr/bin/env python3
"""Binary Reflection - Perl Weekly Challenge 397 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def binary_reflection(num: int) -> int:
    """Return decimal value of the reversed binary representation of num."""
    if num == 0:
        return 0
    bin_str = bin(num)[2:]
    return int(bin_str[::-1], 2)


def sort_by_binary_reflection(arr: Sequence[int]) -> list[int]:
    """Sort arr ascending by binary reflection, breaking ties by original value."""
    return sorted(arr, key=lambda x: (binary_reflection(x), x))


class TestBinaryReflection(unittest.TestCase):
    """Unit tests for sort_by_binary_reflection."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(sort_by_binary_reflection([3, 6, 12]), [3, 6, 12])

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(sort_by_binary_reflection([1, 2, 4, 8]), [1, 2, 4, 8])

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(sort_by_binary_reflection([7, 8, 9, 10]), [8, 10, 7, 9])

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(sort_by_binary_reflection([5, 9, 15, 17]), [5, 9, 15, 17])

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(sort_by_binary_reflection([11, 13, 14, 19]), [14, 13, 11, 19])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        arr = [int(x) for x in argv[1:]]
        out = sort_by_binary_reflection(arr)
        print(f"Output: ({', '.join(str(x) for x in out)})")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
