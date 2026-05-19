#!/usr/bin/env python3
"""Largest Same-digits Number - Perl Weekly Challenge 374 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest
import re


def largest_same_digits(text: str) -> str:
    """Return the largest number with all identical digits."""
    if not text:
        return ""

    # Find all runs of identical digits
    runs = re.findall(r"((\d)\2*)", text)
    best = ""
    for run, _ in runs:
        # Compare numerically; if equal, prefer longer
        if int(run) > int(best) if best else True:
            best = run
    return best


class LargestSameDigitsExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(largest_same_digits("6777133339"), "3333")

    def test_example_2(self) -> None:
        self.assertEqual(largest_same_digits("1200034"), "4")

    def test_example_3(self) -> None:
        self.assertEqual(largest_same_digits("44221155"), "55")

    def test_example_4(self) -> None:
        self.assertEqual(largest_same_digits("88888"), "88888")

    def test_example_5(self) -> None:
        self.assertEqual(largest_same_digits("11122233"), "222")


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <string>")
    text = args[0]
    result = largest_same_digits(text)
    print(f'Input: $str = "{text}"')
    print(f'Output: "{result}"')


if __name__ == "__main__":
    main()
