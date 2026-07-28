#!/usr/bin/env python3
"""Base N - Perl Weekly Challenge 384 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def convert_base(num: int, base: int) -> str:
    """Convert a decimal number to the given base (2 to 64)."""
    if not (2 <= base <= 64):
        raise ValueError("Base must be between 2 and 64")
    if num == 0:
        return "0"

    digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/"
    result = []

    while num > 0:
        rem = num % base
        result.append(digits[rem])
        num //= base

    return "".join(reversed(result))


class BaseNExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(convert_base(42, 2), "101010")

    def test_example_2(self) -> None:
        self.assertEqual(convert_base(15642094, 16), "EEADEE")

    def test_example_3(self) -> None:
        self.assertEqual(convert_base(493, 8), "755")

    def test_example_4(self) -> None:
        self.assertEqual(convert_base(2228519, 36), "1BRJB")

    def test_example_5(self) -> None:
        self.assertEqual(convert_base(123456789, 64), "7MyqL")


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-1.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
