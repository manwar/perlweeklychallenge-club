#!/usr/bin/env python3
"""Unicode Makeover - Perl Weekly Challenge 186 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unicodedata
import unittest


def makeover(text: str) -> str:
    """Replace unicode alphabetic characters with ASCII equivalents."""
    normalized = unicodedata.normalize("NFD", text)
    return "".join(ch for ch in normalized if unicodedata.category(ch) != "Mn")


class UnicodeMakeoverExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(makeover("ÃÊÍÒÙ"), "AEIOU")

    def test_example_2(self) -> None:
        self.assertEqual(makeover("âÊíÒÙ"), "aEiOU")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    text = " ".join(args)
    print(f"Input:  $str = '{text}'")
    print(f"Output: '{makeover(text)}'")


if __name__ == "__main__":
    main()

