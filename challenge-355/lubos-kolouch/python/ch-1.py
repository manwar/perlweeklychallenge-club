#!/usr/bin/env python3
"""Thousand Separator - Perl Weekly Challenge 355 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def thousand_separator(value: int) -> str:
    """Format positive integer with commas as thousands separators."""
    if value <= 0:
        raise ValueError("Expected a positive integer")
    s = str(value)[::-1]
    parts = [s[i : i + 3] for i in range(0, len(s), 3)]
    return ",".join(part[::-1] for part in parts[::-1])


class ThousandSeparatorExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(thousand_separator(123), "123")

    def test_example_2(self) -> None:
        self.assertEqual(thousand_separator(1234), "1,234")

    def test_example_3(self) -> None:
        self.assertEqual(thousand_separator(1_000_000), "1,000,000")

    def test_example_4(self) -> None:
        self.assertEqual(thousand_separator(1), "1")

    def test_example_5(self) -> None:
        self.assertEqual(thousand_separator(12345), "12,345")


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
    print(f'Output: "{thousand_separator(value)}"')


if __name__ == "__main__":
    main()

