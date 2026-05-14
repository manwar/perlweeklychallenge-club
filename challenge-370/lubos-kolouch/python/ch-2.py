#!/usr/bin/env python3
"""Scramble String - Perl Weekly Challenge 370 task 2."""

from functools import lru_cache
from collections.abc import Sequence
import sys
import unittest


@lru_cache(maxsize=None)
def _is_scramble(s1: str, s2: str) -> bool:
    """Return True if s2 is a scramble of s1 using recursion + memoisation."""
    if s1 == s2:
        return True
    if sorted(s1) != sorted(s2):  # prune: different character multisets
        return False

    n = len(s1)
    # Try every split position
    for i in range(1, n):
        # No swap: s1[0:i] ~ s2[0:i] and s1[i:] ~ s2[i:]
        if _is_scramble(s1[:i], s2[:i]) and _is_scramble(s1[i:], s2[i:]):
            return True
        # Swap: s1[0:i] ~ s2[n-i:] and s1[i:] ~ s2[0:n-i]
        if _is_scramble(s1[:i], s2[n - i :]) and _is_scramble(s1[i:], s2[: n - i]):
            return True
    return False


def scramble_string(str1: str, str2: str) -> bool:
    """Public wrapper – matches the Perl interface (returns True/False)."""
    if len(str1) != len(str2):
        return False
    return _is_scramble(str1, str2)


class ScrambleStringExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertTrue(scramble_string("great", "rgeat"))

    def test_example_2(self) -> None:
        self.assertFalse(scramble_string("abcde", "caebd"))

    def test_example_3(self) -> None:
        self.assertTrue(scramble_string("a", "a"))

    def test_example_4(self) -> None:
        self.assertTrue(scramble_string("abc", "bca"))

    def test_different_lengths(self) -> None:
        self.assertFalse(scramble_string("a", "ab"))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-2.py <string1> <string2>")

    s1, s2 = args
    result = "true" if scramble_string(s1, s2) else "false"
    print(f'Input: $s1 = "{s1}", $s2 = "{s2}"')
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
