#!/usr/bin/env python3
"""Second Largest Digit - Perl Weekly Challenge 378 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def second_largest_digit(s: str) -> int:
    """Find the second largest distinct digit in the given string. Return -1 if none found."""
    digits = [int(char) for char in s if char.isdigit()]
    unique_digits = sorted(list(set(digits)), reverse=True)
    if len(unique_digits) >= 2:
        return unique_digits[1]
    return -1


class SecondLargestDigitExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(second_largest_digit("aaaaa77777"), -1)

    def test_example_2(self) -> None:
        self.assertEqual(second_largest_digit("abcde"), -1)

    def test_example_3(self) -> None:
        self.assertEqual(second_largest_digit("9zero8eight7seven9"), 8)

    def test_example_4(self) -> None:
        self.assertEqual(second_largest_digit("xyz9876543210"), 8)

    def test_example_5(self) -> None:
        self.assertEqual(second_largest_digit("4abc4def2ghi8jkl2"), 4)


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
