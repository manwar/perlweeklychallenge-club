#!/usr/bin/env python3
"""Subsequence - Perl Weekly Challenge 316 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def is_subsequence(str1: str, str2: str) -> bool:
    """Return True if str1 is a subsequence of str2."""
    if not str1:
        return True

    idx = 0
    for ch in str2:
        if ch == str1[idx]:
            idx += 1
            if idx == len(str1):
                return True
    return False


class SubsequenceExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertTrue(is_subsequence("uvw", "bcudvew"))

    def test_example_2(self) -> None:
        self.assertFalse(is_subsequence("aec", "abcde"))

    def test_example_3(self) -> None:
        self.assertTrue(is_subsequence("sip", "javascript"))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-2.py <str1> <str2>")

    str1, str2 = args
    result = "true" if is_subsequence(str1, str2) else "false"
    print(f'Input: $str1 = "{str1}", $str2 = "{str2}"')
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
