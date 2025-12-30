#!/usr/bin/env python3
"""Digit Count Value - Perl Weekly Challenge 283 task 2."""

from __future__ import annotations

from collections import Counter
from collections.abc import Sequence
import sys
import unittest


def digit_count_value(ints: Sequence[int]) -> bool:
    """Return True if each value i occurs exactly ints[i] times."""
    counts = Counter(ints)
    for i, expected in enumerate(ints):
        if counts.get(i, 0) != expected:
            return False
    return True


class DigitCountValueExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertTrue(digit_count_value((1, 2, 1, 0)))

    def test_example_2(self) -> None:
        self.assertFalse(digit_count_value((0, 3, 0)))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    ints = [int(token) for token in args]
    result = "true" if digit_count_value(ints) else "false"
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
