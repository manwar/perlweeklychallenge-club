#!/usr/bin/env python3
"""Complete Day - Perl Weekly Challenge 276 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def complete_day_pairs(hours: Sequence[int]) -> int:
    """Count pairs with sum divisible by 24."""
    counts = [0] * 24
    for h in hours:
        counts[h % 24] += 1

    pairs = 0
    pairs += counts[0] * (counts[0] - 1) // 2
    pairs += counts[12] * (counts[12] - 1) // 2
    for r in range(1, 12):
        pairs += counts[r] * counts[24 - r]
    return pairs


class CompleteDayExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(complete_day_pairs((12, 12, 30, 24, 24)), 2)

    def test_example_2(self) -> None:
        self.assertEqual(complete_day_pairs((72, 48, 24, 5)), 3)

    def test_example_3(self) -> None:
        self.assertEqual(complete_day_pairs((12, 18, 24)), 0)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    hours = [int(token) for token in args]
    print(f"Input:  @hours = ({', '.join(str(x) for x in hours)})")
    print(f"Output: {complete_day_pairs(hours)}")


if __name__ == "__main__":
    main()

