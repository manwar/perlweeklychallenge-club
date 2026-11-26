#!/usr/bin/env python3
"""Most Frequent Letter Pair - Perl Weekly Challenge 247, Task 2."""

from __future__ import annotations

from collections import Counter
import unittest


def most_frequent_letter_pair(s: str) -> str:
    """Return the most frequent consecutive two-letter pair, breaking ties lexicographically."""
    if len(s) < 2:
        return ""

    pairs = Counter(s[i : i + 2] for i in range(len(s) - 1))
    best, _ = min(pairs.items(), key=lambda item: (-item[1], item[0]))
    return best


class TestMostFrequentLetterPair(unittest.TestCase):
    """Unit tests for the most_frequent_letter_pair function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[str, str]] = [
            ("abcdbca", "bc"),
            ("cdeabeabfcdfabgcd", "ab"),
        ]
        for s, expected in cases:
            with self.subTest(s=s):
                self.assertEqual(most_frequent_letter_pair(s), expected)


if __name__ == "__main__":
    unittest.main()
