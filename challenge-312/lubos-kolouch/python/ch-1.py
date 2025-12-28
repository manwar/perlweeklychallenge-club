#!/usr/bin/env python3
"""Minimum Time - Perl Weekly Challenge 312 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def minimum_time(text: str) -> int:
    """
    Return minimum time to type text on a circular typewriter (a-z).

    Start at 'a'. Each move step costs 1 second; typing each character costs 1 second.
    """
    pos = 0
    total = 0
    for ch in text:
        target = ord(ch) - ord("a")
        diff = abs(target - pos)
        total += min(diff, 26 - diff) + 1
        pos = target
    return total


class MinimumTimeExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(minimum_time("abc"), 5)

    def test_example_2(self) -> None:
        self.assertEqual(minimum_time("bza"), 7)

    def test_example_3(self) -> None:
        self.assertEqual(minimum_time("zjpc"), 34)


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
    print(f"Output: {minimum_time(text)}")


if __name__ == "__main__":
    main()
