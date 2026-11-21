#!/usr/bin/env python3
"""Longest Repeating Character - Perl Weekly Challenge 399, Task 1."""

from __future__ import annotations

from collections import defaultdict
import unittest


def longest_repeating_character(text: str, k: int) -> int:
    """Return the longest single-letter substring length with at most k edits."""
    counts: dict[str, int] = defaultdict(int)
    left = 0
    max_freq = 0
    best = 0

    for right, ch in enumerate(text):
        counts[ch] += 1
        max_freq = max(max_freq, counts[ch])

        while (right - left + 1) - max_freq > k:
            counts[text[left]] -= 1
            left += 1

        best = max(best, right - left + 1)

    return best


class TestLongestRepeatingCharacter(unittest.TestCase):
    """Unit tests for the longest_repeating_character function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[str, int, int]] = [
            ("AAAAA", 2, 5),
            ("ABCDE", 4, 5),
            ("AAABBBBAA", 1, 5),
            ("ABACADA", 2, 5),
            ("BAAABAAAA", 1, 8),
        ]
        for text, k, expected in cases:
            with self.subTest(text=text, k=k):
                self.assertEqual(longest_repeating_character(text, k), expected)


if __name__ == "__main__":
    unittest.main()
