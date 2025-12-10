#!/usr/bin/env python3
"""Arithmetic Progression - Perl Weekly Challenge 351 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import math
import sys
import unittest


def can_form_arithmetic_progression(numbers: Sequence[float]) -> bool:
    """
    Return True if ``numbers`` can be reordered into an arithmetic progression.

    Sorting the values reveals whether a single common difference exists between
    adjacent elements. ``math.isclose`` is used to accommodate floating point
    inputs such as the 1.5 step shown in the examples.
    """
    if len(numbers) <= 2:
        return True

    sorted_numbers = sorted(numbers)
    common_diff = sorted_numbers[1] - sorted_numbers[0]

    for idx in range(2, len(sorted_numbers)):
        current = sorted_numbers[idx] - sorted_numbers[idx - 1]
        if not math.isclose(current, common_diff, rel_tol=1e-9, abs_tol=1e-9):
            return False
    return True


class ArithmeticProgressionExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertTrue(can_form_arithmetic_progression((1, 3, 5, 7, 9)))

    def test_example_2(self) -> None:
        self.assertTrue(can_form_arithmetic_progression((9, 1, 7, 5, 3)))

    def test_example_3(self) -> None:
        self.assertFalse(can_form_arithmetic_progression((1, 2, 4, 8, 16)))

    def test_example_4(self) -> None:
        self.assertTrue(can_form_arithmetic_progression((5, -1, 3, 1, -3)))

    def test_example_5(self) -> None:
        self.assertTrue(can_form_arithmetic_progression((1.5, 3, 0, 4.5, 6)))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    numbers = [float(value) for value in args]
    result = "true" if can_form_arithmetic_progression(numbers) else "false"
    print(f"Input:  @num = ({', '.join(args)})")
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
