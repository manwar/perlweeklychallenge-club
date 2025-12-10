#!/usr/bin/env python3
"""Special Average - Perl Weekly Challenge 351 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def special_average(ints: Sequence[float]) -> float:
    """
    Return the average after removing all occurrences of the minimum and maximum.

    If removing the extrema leaves no elements (including the case where all
    numbers are identical), the function returns 0.0 as specified in the task.
    """
    if not ints:
        return 0.0

    min_val = min(ints)
    max_val = max(ints)

    if min_val == max_val:
        return 0.0

    remaining = [value for value in ints if value != min_val and value != max_val]
    if not remaining:
        return 0.0

    return sum(remaining) / len(remaining)


class SpecialAverageExamples(unittest.TestCase):
    """Example-based tests from the challenge specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            special_average((8000, 5000, 6000, 2000, 3000, 7000)), 5250
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            special_average((100_000, 80_000, 110_000, 90_000)), 95_000
        )

    def test_example_3(self) -> None:
        self.assertEqual(special_average((2500, 2500, 2500, 2500)), 0)

    def test_example_4(self) -> None:
        self.assertEqual(special_average((2000,)), 0)

    def test_example_5(self) -> None:
        self.assertEqual(
            special_average((1000, 2000, 3000, 4000, 5000, 6000)), 3500
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    numbers = [float(value) for value in args]
    result = special_average(numbers)
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: {result:g}")


if __name__ == "__main__":
    main()
