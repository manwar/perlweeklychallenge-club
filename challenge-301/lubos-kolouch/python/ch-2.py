#!/usr/bin/env python3
"""Hamming Distance - Perl Weekly Challenge 301 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def hamming_distance_sum(ints: Sequence[int]) -> int:
    """Return sum of Hamming distances over all unordered pairs of integers."""
    total = 0
    for i in range(len(ints) - 1):
        for j in range(i + 1, len(ints)):
            total += bin(ints[i] ^ ints[j]).count("1")
    return total


class HammingDistanceExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(hamming_distance_sum((4, 14, 2)), 6)

    def test_example_2(self) -> None:
        self.assertEqual(hamming_distance_sum((4, 14, 4)), 4)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    values = [int(token) for token in args]
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: {hamming_distance_sum(values)}")


if __name__ == "__main__":
    main()
