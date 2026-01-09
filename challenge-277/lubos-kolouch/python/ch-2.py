#!/usr/bin/env python3
"""Strong Pair - Perl Weekly Challenge 277 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def strong_pairs(ints: Sequence[int]) -> int:
    """Count strong pairs among distinct values.

    A pair (x, y) is strong if 0 < abs(x - y) < min(x, y).
    Pairs are unordered and duplicates in the input do not create extra pairs.
    """
    vals = sorted(set(ints))
    count = 0
    for i, x in enumerate(vals):
        for y in vals[i + 1 :]:
            diff = y - x
            if 0 < diff < min(x, y):
                count += 1
    return count


class StrongPairExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(strong_pairs((1, 2, 3, 4, 5)), 4)

    def test_example_2(self) -> None:
        self.assertEqual(strong_pairs((5, 7, 1, 7)), 1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    ints = [int(token) for token in args]
    print(f"Input:  @ints = ({', '.join(str(x) for x in ints)})")
    print(f"Output: {strong_pairs(ints)}")


if __name__ == "__main__":
    main()

