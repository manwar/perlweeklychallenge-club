#!/usr/bin/env python3
"""Step by Step - Perl Weekly Challenge 302 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def minimum_start_value(ints: Sequence[int]) -> int:
    """Return minimum positive start value so running sum never drops below 1."""
    prefix = 0
    min_prefix = 0
    for value in ints:
        prefix += value
        if prefix < min_prefix:
            min_prefix = prefix
    return 1 - min_prefix


class StepByStepExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(minimum_start_value((-3, 2, -3, 4, 2)), 5)

    def test_example_2(self) -> None:
        self.assertEqual(minimum_start_value((1, 2)), 1)

    def test_example_3(self) -> None:
        self.assertEqual(minimum_start_value((1, -2, -3)), 5)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    ints = [int(token) for token in args]
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: {minimum_start_value(ints)}")


if __name__ == "__main__":
    main()
