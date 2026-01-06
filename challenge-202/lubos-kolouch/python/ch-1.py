#!/usr/bin/env python3
"""Consecutive Odds - Perl Weekly Challenge 202 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def consecutive_odds(array: Sequence[int]) -> int:
    """Return 1 if there are three consecutive odds, otherwise 0."""
    run = 0
    for x in array:
        if x % 2 != 0:
            run += 1
            if run >= 3:
                return 1
        else:
            run = 0
    return 0


class ConsecutiveOddsExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(consecutive_odds((1, 5, 3, 6)), 1)

    def test_example_2(self) -> None:
        self.assertEqual(consecutive_odds((2, 6, 3, 5)), 0)

    def test_example_3(self) -> None:
        self.assertEqual(consecutive_odds((1, 2, 3, 4)), 0)

    def test_example_4(self) -> None:
        self.assertEqual(consecutive_odds((2, 3, 5, 7)), 1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    array = [int(token) for token in args]
    print(f"Input:  @array = ({', '.join(str(x) for x in array)})")
    print(f"Output: {consecutive_odds(array)}")


if __name__ == "__main__":
    main()

