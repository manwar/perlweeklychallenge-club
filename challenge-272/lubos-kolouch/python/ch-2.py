#!/usr/bin/env python3
"""String Score - Perl Weekly Challenge 272 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def string_score(text: str) -> int:
    """Return score as sum of absolute differences of adjacent ASCII codes."""
    if len(text) <= 1:
        return 0
    score = 0
    for a, b in zip(text, text[1:]):
        score += abs(ord(a) - ord(b))
    return score


class StringScoreExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(string_score("hello"), 13)

    def test_example_2(self) -> None:
        self.assertEqual(string_score("perl"), 30)

    def test_example_3(self) -> None:
        self.assertEqual(string_score("raku"), 37)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <str>")
    text = args[0]
    print(f'Input:  $str = "{text}"')
    print(f"Output: {string_score(text)}")


if __name__ == "__main__":
    main()

