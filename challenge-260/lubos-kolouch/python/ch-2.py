#!/usr/bin/env python3
"""Dictionary Rank - Perl Weekly Challenge 260 Task 2."""

from __future__ import annotations

from collections import Counter
from math import factorial, prod
import unittest


def dictionary_rank(word: str) -> int:
    """Compute the 1-based dictionary rank of the given word."""
    length = len(word)
    char_counts: dict[str, int] = dict(Counter(word))
    rank = 1

    for i, char in enumerate(word):
        smaller_chars = sum(count for c, count in char_counts.items() if c < char)
        denom = prod(factorial(c) for c in char_counts.values())
        rank += smaller_chars * factorial(length - i - 1) // denom

        char_counts[char] -= 1
        if char_counts[char] == 0:
            del char_counts[char]

    return rank


class TestDictionaryRank(unittest.TestCase):
    """Unit tests for dictionary_rank."""

    def test_example_1(self) -> None:
        """Test Example 1: 'CAT' -> 3."""
        self.assertEqual(dictionary_rank("CAT"), 3)

    def test_example_2(self) -> None:
        """Test Example 2: 'GOOGLE' -> 88."""
        self.assertEqual(dictionary_rank("GOOGLE"), 88)

    def test_example_3(self) -> None:
        """Test Example 3: 'SECRET' -> 255."""
        self.assertEqual(dictionary_rank("SECRET"), 255)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
