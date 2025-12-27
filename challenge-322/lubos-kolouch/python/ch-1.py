#!/usr/bin/env python3
"""String Format - Perl Weekly Challenge 322 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def string_format(text: str, size: int) -> str:
    """
    Format the string by removing dashes and grouping from the end.

    Groups have length ``size`` except the first group which may be shorter.
    """
    if size <= 0:
        raise ValueError("Expected a positive group size")

    cleaned = text.replace("-", "")
    if not cleaned:
        return ""

    groups: list[str] = []
    while len(cleaned) > size:
        groups.append(cleaned[-size:])
        cleaned = cleaned[:-size]
    groups.append(cleaned)
    return "-".join(reversed(groups))


class StringFormatExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(string_format("ABC-D-E-F", 3), "ABC-DEF")

    def test_example_2(self) -> None:
        self.assertEqual(string_format("A-BC-D-E", 2), "A-BC-DE")

    def test_example_3(self) -> None:
        self.assertEqual(string_format("-A-B-CD-E", 4), "A-BCDE")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-1.py <string> <i>")

    text = args[0]
    size = int(args[1])
    result = string_format(text, size)
    print(f'Input: $str = "{text}", $i = {size}')
    print(f'Output: "{result}"')


if __name__ == "__main__":
    main()
