#!/usr/bin/env python3
"""Reverse String - Perl Weekly Challenge 379 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def reverse_string(s: str) -> str:
    """Reverse the given string without using the standard reverse function."""
    reversed_str = ""
    for char in s:
        reversed_str = char + reversed_str
    return reversed_str


class ReverseStringExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(reverse_string("weekly"), "ylkeew")

    def test_example_2(self) -> None:
        self.assertEqual(reverse_string("challenge"), "egnellahc")

    def test_example_3(self) -> None:
        self.assertEqual(reverse_string("12345"), "54321")


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-1.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
