#!/usr/bin/env python3
"""Upper Lower - Perl Weekly Challenge 311 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def upper_lower(text: str) -> str:
    """Swap case of each alphabetic character."""
    return "".join(ch.lower() if ch.isupper() else ch.upper() for ch in text)


class UpperLowerExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(upper_lower("pERl"), "PerL")

    def test_example_2(self) -> None:
        self.assertEqual(upper_lower("rakU"), "RAKu")

    def test_example_3(self) -> None:
        self.assertEqual(upper_lower("PyThOn"), "pYtHoN")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <string>")

    text = args[0]
    print(f'Input: $str = "{text}"')
    print(f'Output: "{upper_lower(text)}"')


if __name__ == "__main__":
    main()
