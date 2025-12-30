#!/usr/bin/env python3
"""Good Integer - Perl Weekly Challenge 282 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def good_integer(value: int) -> str:
    """Return the first good 3-digit substring, or '-1' if none exists.

    A good integer contains exactly three consecutive matching digits that are
    not part of a longer run of that same digit.
    """
    s = str(value)
    n = len(s)
    if n < 3:
        return "-1"

    for i in range(n - 2):
        d = s[i]
        if s[i + 1] != d or s[i + 2] != d:
            continue

        prev_ok = i == 0 or s[i - 1] != d
        next_ok = i + 3 >= n or s[i + 3] != d
        if prev_ok and next_ok:
            return d * 3

    return "-1"


class GoodIntegerExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(good_integer(12344456), "444")

    def test_example_2(self) -> None:
        self.assertEqual(good_integer(1233334), "-1")

    def test_example_3(self) -> None:
        self.assertEqual(good_integer(10020003), "000")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <int>")
    value = int(args[0])
    print(f"Input:  $int = {value}")
    print(f"Output: {good_integer(value)}")


if __name__ == "__main__":
    main()

