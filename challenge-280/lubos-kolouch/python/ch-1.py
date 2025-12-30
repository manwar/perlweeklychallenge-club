#!/usr/bin/env python3
"""Twice Appearance - Perl Weekly Challenge 280 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def twice_appearance(text: str) -> str:
    """Return the first letter that appears twice scanning left-to-right."""
    if not text.islower() or not text.isalpha():
        raise ValueError("Expected lowercase English letters only")

    seen: set[str] = set()
    for ch in text:
        if ch in seen:
            return ch
        seen.add(ch)
    return ""


class TwiceAppearanceExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(twice_appearance("acbddbca"), "d")

    def test_example_2(self) -> None:
        self.assertEqual(twice_appearance("abccd"), "c")

    def test_example_3(self) -> None:
        self.assertEqual(twice_appearance("abcdabbb"), "a")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <str>")
    text = args[0]
    print(f'Input:  $str = "{text}"')
    print(f'Output: "{twice_appearance(text)}"')


if __name__ == "__main__":
    main()

