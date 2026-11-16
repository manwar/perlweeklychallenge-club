#!/usr/bin/env python3
"""Most Frequent Word - Perl Weekly Challenge 255 task 2."""

from __future__ import annotations

from collections import Counter
import re
import unittest


def most_frequent_word(p: str, w: str) -> str:
    """Return the most frequent non-banned word in paragraph p."""
    banned = w.lower()
    word_count: Counter[str] = Counter()
    original: dict[str, str] = {}

    for word in re.findall(r"\w+", p):
        key = word.lower()
        if key == banned:
            continue
        original.setdefault(key, word)
        word_count[key] += 1

    if not word_count:
        return ""

    most_frequent = word_count.most_common(1)[0][0]
    return original[most_frequent]


class TestMostFrequentWord(unittest.TestCase):
    """Unit tests for most_frequent_word."""

    def test_example_1(self) -> None:
        """Verify Example 1."""
        self.assertEqual(
            most_frequent_word(
                "Joe hit a ball, the hit ball flew far after it was hit.",
                "hit",
            ),
            "ball",
        )

    def test_example_2(self) -> None:
        """Verify Example 2."""
        self.assertEqual(
            most_frequent_word(
                "Perl and Raku belong to the same family. "
                "Perl is the most popular language in the weekly challenge.",
                "the",
            ),
            "Perl",
        )


if __name__ == "__main__":
    unittest.main()
