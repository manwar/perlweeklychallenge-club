#!/usr/bin/env python3
"""Maximum Count - Perl Weekly Challenge 320 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def maximum_count(ints: Sequence[int]) -> int:
    """Return max(count(>0), count(<0)); zeros are ignored."""
    positives = sum(1 for value in ints if value > 0)
    negatives = sum(1 for value in ints if value < 0)
    return max(positives, negatives)


class MaximumCountExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(maximum_count((-3, -2, -1, 1, 2, 3)), 3)

    def test_example_2(self) -> None:
        self.assertEqual(maximum_count((-2, -1, 0, 0, 1)), 2)

    def test_example_3(self) -> None:
        self.assertEqual(maximum_count((1, 2, 3, 4)), 4)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    ints = [int(value) for value in args]
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: {maximum_count(ints)}")


if __name__ == "__main__":
    main()
