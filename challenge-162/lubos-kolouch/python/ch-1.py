#!/usr/bin/env python3
"""ISBN-13 - Perl Weekly Challenge 162 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import re
import sys
import unittest


NON_DIGITS = re.compile(r"[^0-9]+")


def isbn13_check_digit(code: str) -> int:
    """Return the ISBN-13 check digit for the given code (first 12 digits used)."""
    digits = NON_DIGITS.sub("", code)
    if len(digits) < 12:
        raise ValueError("Need at least 12 digits")
    s = 0
    mul = 1
    for ch in digits[:12]:
        s += int(ch) * mul
        mul = 4 - mul  # 1 <-> 3
    return (10 - (s % 10)) % 10


class Isbn13Examples(unittest.TestCase):
    """Example-based test from the specification."""

    def test_example(self) -> None:
        self.assertEqual(isbn13_check_digit("978-0-306-40615-7"), 7)


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <isbn>")
    code = args[0]
    print(isbn13_check_digit(code))


if __name__ == "__main__":
    main()

