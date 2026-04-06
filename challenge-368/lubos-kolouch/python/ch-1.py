#!/usr/bin/env python3
"""Make it Bigger - Perl Weekly Challenge 368 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def make_it_bigger(number: str, digit: str) -> str:
    """
    Remove exactly one occurrence of *digit* from *number* to maximise
    the resulting decimal value.

    Strategy: remove the first occurrence where the following digit is
    greater.  If no such occurrence exists, remove the last one.
    """
    last_idx = -1
    chars = list(number)

    for i, ch in enumerate(chars):
        if ch == digit:
            last_idx = i
            if i + 1 < len(chars) and chars[i + 1] > digit:
                del chars[i]
                return "".join(chars)

    if last_idx >= 0:
        del chars[last_idx]
    return "".join(chars)


class MakeItBiggerExamples(unittest.TestCase):
    """Example-based tests from the challenge specification."""

    def test_example_1(self) -> None:
        self.assertEqual(make_it_bigger("15456", "5"), "1546")

    def test_example_2(self) -> None:
        self.assertEqual(make_it_bigger("7332", "3"), "732")

    def test_example_3(self) -> None:
        self.assertEqual(make_it_bigger("2231", "2"), "231")

    def test_example_4(self) -> None:
        self.assertEqual(make_it_bigger("543251", "5"), "54321")

    def test_example_5(self) -> None:
        self.assertEqual(make_it_bigger("111", "1"), "11")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-1.py <number> <digit>")

    number, digit = args
    result = make_it_bigger(number, digit)
    print(f'Input:  $str = "{number}", $char = "{digit}"')
    print(f'Output: "{result}"')


if __name__ == "__main__":
    main()
