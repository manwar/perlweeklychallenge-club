#!/usr/bin/env python3
"""Reverse Degree - Perl Weekly Challenge 380 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def reverse_degree(s: str) -> int:
    """Return the reverse degree of the given string."""
    total = 0
    for i, char in enumerate(s.lower()):
        if char.isalpha() and "a" <= char <= "z":
            value = 26 - (ord(char) - ord("a"))
            position = i + 1
            total += value * position
    return total


class ReverseDegreeExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(reverse_degree("z"), 1)

    def test_example_2(self) -> None:
        self.assertEqual(reverse_degree("a"), 26)

    def test_example_3(self) -> None:
        self.assertEqual(reverse_degree("bbc"), 147)


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-2.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
