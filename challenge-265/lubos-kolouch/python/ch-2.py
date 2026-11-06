#!/usr/bin/env python3
"""Shortest Completing Word - Perl Weekly Challenge 265 Task 2."""

from __future__ import annotations

from collections import Counter
import unittest


def _get_letter_counts(s: str) -> Counter[str]:
    """Count case-insensitive alphabetic characters in a string."""
    return Counter(c.lower() for c in s if c.isalpha())


def shortest_completing_word(target: str, words: list[str]) -> str:
    """Find the shortest completing word in the given list of words.

    A completing word contains all letters from the target string (ignoring
    case and non-alpha characters) with at least the same frequency. If multiple
    shortest completing words exist, the one appearing first in the list is returned.
    If no completing word is found, an empty string is returned.
    """
    target_count = _get_letter_counts(target)

    valid_words = [
        word for word in words if not (target_count - _get_letter_counts(word))
    ]
    return min(valid_words, key=len) if valid_words else ""


class TestShortestCompletingWord(unittest.TestCase):
    """Unit tests for shortest_completing_word."""

    def test_example_1(self) -> None:
        """Test Example 1 from challenge description."""
        self.assertEqual(
            shortest_completing_word("aBc 11c", ["accbbb", "abc", "abbc"]),
            "accbbb",
        )

    def test_example_2(self) -> None:
        """Test Example 2 from challenge description."""
        self.assertEqual(
            shortest_completing_word("Da2 abc", ["abcm", "baacd", "abaadc"]),
            "baacd",
        )

    def test_example_3(self) -> None:
        """Test Example 3 from challenge description."""
        self.assertEqual(shortest_completing_word("JB 007", ["jj", "bb", "bjb"]), "bjb")

    def test_no_match(self) -> None:
        """Test when no completing word exists."""
        self.assertEqual(
            shortest_completing_word("xyz", ["apple", "banana", "orange"]), ""
        )

    def test_tie_picks_first(self) -> None:
        """Test that when multiple shortest words have the same length, first is chosen."""
        self.assertEqual(shortest_completing_word("ab", ["cba", "bac"]), "cba")


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
