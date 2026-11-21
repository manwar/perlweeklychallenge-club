#!/usr/bin/env python3
"""String Difference - Perl Weekly Challenge 398, Task 2."""

from __future__ import annotations

from collections import defaultdict
import unittest


def string_difference(words: list[str]) -> str:
    """Return the word whose adjacent character difference array is unique."""
    groups: dict[tuple[int, ...], list[str]] = defaultdict(list)
    for word in words:
        sig = tuple(ord(word[i + 1]) - ord(word[i]) for i in range(len(word) - 1))
        groups[sig].append(word)

    for group in groups.values():
        if len(group) == 1:
            return group[0]
    return ""


class TestStringDifference(unittest.TestCase):
    """Unit tests for the string_difference function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[list[str], str]] = [
            (["ab", "bc", "cd", "zy"], "zy"),
            (["cba", "fed", "azy"], "azy"),
            (["pop", "ada", "beb", "cfc"], "pop"),
            (["aaaa", "zzzz", "mmmm", "aaba"], "aaba"),
            (["aceg", "bdfh", "cegi", "azbz"], "azbz"),
        ]
        for words, expected in cases:
            with self.subTest(words=words):
                self.assertEqual(string_difference(words), expected)


if __name__ == "__main__":
    unittest.main()
