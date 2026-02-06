#!/usr/bin/env python3
"""
Perl Weekly Challenge 099 - Task 1: Pattern Match

Given a string S and a pattern P, check whether P matches the entire string.

Pattern rules:
- '?' matches any single character
- '*' matches any sequence of characters (including empty)
"""

from __future__ import annotations

from functools import lru_cache
from typing import Sequence


def pattern_match(s: str, p: str) -> int:
    """Return 1 if pattern `p` matches the entire string `s`, else 0."""

    @lru_cache(maxsize=None)
    def matches(i: int, j: int) -> bool:
        if j == len(p):
            return i == len(s)

        token = p[j]
        if token == "*":
            return matches(i, j + 1) or (i < len(s) and matches(i + 1, j))
        if token == "?":
            return i < len(s) and matches(i + 1, j + 1)
        return i < len(s) and s[i] == token and matches(i + 1, j + 1)

    return 1 if matches(0, 0) else 0


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <S> <P>")
    print(pattern_match(argv[0], argv[1]))


def _run_tests() -> None:
    import unittest

    class TestChallenge099Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(pattern_match("abcde", "a*e"), 1)

        def test_example_2(self) -> None:
            self.assertEqual(pattern_match("abcde", "a*d"), 0)

        def test_example_3(self) -> None:
            self.assertEqual(pattern_match("abcde", "?b*d"), 0)

        def test_example_4(self) -> None:
            self.assertEqual(pattern_match("abcde", "a*c?e"), 1)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge099Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

