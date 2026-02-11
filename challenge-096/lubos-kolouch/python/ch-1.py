#!/usr/bin/env python3
"""
Perl Weekly Challenge 096 - Task 1: Reverse Words

You are given a string S that may contain leading/trailing spaces and multiple
spaces between words.

Reverse the order of the words and return a string with:
- no leading/trailing spaces
- exactly one space between words
"""

from __future__ import annotations

from typing import Sequence


def reverse_words(s: str) -> str:
    """Return the words of `s` in reverse order with normalized spacing."""
    words = s.split()
    words.reverse()
    return " ".join(words)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    print(reverse_words(" ".join(argv)))


def _run_tests() -> None:
    import unittest

    class TestChallenge096Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(reverse_words("The Weekly Challenge"), "Challenge Weekly The")

        def test_example_2(self) -> None:
            self.assertEqual(
                reverse_words("    Perl and   Raku are  part of the same family  "),
                "family same the of part are Raku and Perl",
            )

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge096Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

