#!/usr/bin/env python3
"""Sum Difference - Perl Weekly Challenge 320 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def sum_difference(ints: Sequence[int]) -> int:
    """Return abs(sum(ints) - sum(digits across ints)); ints must be positive."""
    if any(value <= 0 for value in ints):
        raise ValueError("Expected positive integers only")

    element_sum = sum(ints)
    digit_sum = sum(int(digit) for value in ints for digit in str(value))
    return abs(element_sum - digit_sum)


class SumDifferenceExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(sum_difference((1, 23, 4, 5)), 18)

    def test_example_2(self) -> None:
        self.assertEqual(sum_difference((1, 2, 3, 4, 5)), 0)

    def test_example_3(self) -> None:
        self.assertEqual(sum_difference((1, 2, 34)), 27)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    ints = [int(value) for value in args]
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: {sum_difference(ints)}")


if __name__ == "__main__":
    main()
