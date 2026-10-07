#!/usr/bin/env python3
"""Word Break - Perl Weekly Challenge 295 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def word_break(s: str, words: Sequence[str]) -> str:
    """Determine if string s can be segmented into words from given sequence."""
    word_set = set(words)
    length = len(s)
    dp = [False] * (length + 1)
    dp[0] = True

    for i in range(1, length + 1):
        for j in range(i):
            if dp[j] and s[j:i] in word_set:
                dp[i] = True
                break

    return "true" if dp[length] else "false"


class TestWordBreak(unittest.TestCase):
    """Unit tests for word_break."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(word_break("weeklychallenge", ["challenge", "weekly"]), "true")

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(word_break("perlrakuperl", ["raku", "perl"]), "true")

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(
            word_break("sonsanddaughters", ["sons", "sand", "daughters"]), "false"
        )

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(word_break("applepenapple", ["apple", "pen"]), "true")

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(
            word_break("catsandog", ["cats", "dog", "sand", "and", "cat"]), "false"
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 2:
        print(f"Output: {word_break(argv[1], argv[2:])}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
