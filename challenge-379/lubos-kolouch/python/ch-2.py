#!/usr/bin/env python3
"""Armstrong Number - Perl Weekly Challenge 379 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def get_digits_base(num: int, base: int) -> list[int]:
    """Convert a base-10 number to a list of digits in the specified base."""
    if num == 0:
        return [0]
    digits = []
    temp = num
    while temp > 0:
        digits.append(temp % base)
        temp //= base
    return digits


def is_armstrong(num: int, base: int) -> bool:
    """Check if the number is an Armstrong number in the specified base."""
    digits = get_digits_base(num, base)
    k = len(digits)
    return sum(d**k for d in digits) == num


def find_armstrongs(base: int, limit: int) -> list[int]:
    """Find all Armstrong numbers in the specified base less than the limit."""
    return [i for i in range(limit) if is_armstrong(i, base)]


class ArmstrongNumberExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(find_armstrongs(3, 20), [0, 1, 2, 5, 8, 17])

    def test_example_2(self) -> None:
        self.assertEqual(
            find_armstrongs(10, 1000),
            [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407],
        )


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-2.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
