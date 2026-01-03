#!/usr/bin/env python3
"""Percentage of Character - Perl Weekly Challenge 273 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def percentage_of_character(text: str, char: str) -> int:
    """Return rounded percentage of `char` occurrences in `text`."""
    if len(char) != 1:
        raise ValueError("Expected a single character")
    if not text:
        raise ValueError("Expected non-empty string")

    count = text.count(char)
    pct = (count / len(text)) * 100.0
    return int(pct + 0.5)


class PercentageExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(percentage_of_character("perl", "e"), 25)

    def test_example_2(self) -> None:
        self.assertEqual(percentage_of_character("java", "a"), 50)

    def test_example_3(self) -> None:
        self.assertEqual(percentage_of_character("python", "m"), 0)

    def test_example_4(self) -> None:
        self.assertEqual(percentage_of_character("ada", "a"), 67)

    def test_example_5(self) -> None:
        self.assertEqual(percentage_of_character("ballerina", "l"), 22)

    def test_example_6(self) -> None:
        self.assertEqual(percentage_of_character("analitik", "k"), 13)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-1.py <str> <char>")
    text, char = args
    print(f'Input:  $str = "{text}", $char = "{char}"')
    print(f"Output: {percentage_of_character(text, char)}")


if __name__ == "__main__":
    main()

