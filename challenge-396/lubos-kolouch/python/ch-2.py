#!/usr/bin/env python3
"""Trionic Array - Perl Weekly Challenge 396 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def is_trionic(arr: Sequence[int]) -> bool:
    """Return True if array follows strictly increasing-decreasing-increasing pattern."""
    n = len(arr)
    if n < 4:
        return False

    i = 0

    # Phase 1: Strictly increasing to peak p
    while i + 1 < n and arr[i] < arr[i + 1]:
        i += 1

    p = i
    if p == 0 or p >= n - 2:
        return False

    # Phase 2: Strictly decreasing to valley q
    while i + 1 < n and arr[i] > arr[i + 1]:
        i += 1

    q = i
    if q == p or q >= n - 1:
        return False

    # Phase 3: Strictly increasing to end
    while i + 1 < n and arr[i] < arr[i + 1]:
        i += 1

    return i == n - 1


class TestTrionicArray(unittest.TestCase):
    """Unit tests for is_trionic."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertTrue(is_trionic([1, 3, 5, 4, 2, 6, 8]))

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertFalse(is_trionic([1, 4, 4, 2, 1, 3, 5]))

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertTrue(is_trionic([2, 10, 3, 1, 9]))

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertFalse(is_trionic([1, 2, 3, 4, 3, 2, 1]))

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertFalse(is_trionic([1, 3, 2, 4, 1, 5, 2]))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    _ = argv
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
