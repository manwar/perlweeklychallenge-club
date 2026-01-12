#!/usr/bin/env python3
"""Kolakoski Sequence - Perl Weekly Challenge 356 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def kolakoski_ones(n: int) -> int:
    """Return count of 1s in first n terms of the Kolakoski sequence (n > 3)."""
    if n <= 3:
        raise ValueError("Expected n > 3")

    seq: list[int] = [1, 2, 2]
    read_idx = 2
    next_val = 1
    while len(seq) < n:
        run = seq[read_idx]
        read_idx += 1
        seq.extend([next_val] * run)
        next_val = 2 if next_val == 1 else 1
    seq = seq[:n]
    return sum(1 for x in seq if x == 1)


class KolakoskiExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(kolakoski_ones(4), 2)

    def test_example_2(self) -> None:
        self.assertEqual(kolakoski_ones(5), 3)

    def test_example_3(self) -> None:
        self.assertEqual(kolakoski_ones(6), 3)

    def test_example_4(self) -> None:
        self.assertEqual(kolakoski_ones(7), 4)

    def test_example_5(self) -> None:
        self.assertEqual(kolakoski_ones(8), 4)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <int>")
    n = int(args[0])
    print(f"Input:  $int = {n}")
    print(f"Output: {kolakoski_ones(n)}")


if __name__ == "__main__":
    main()

