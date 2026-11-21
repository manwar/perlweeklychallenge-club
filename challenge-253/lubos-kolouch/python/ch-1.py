#!/usr/bin/env python3
"""Split Strings - Perl Weekly Challenge 253, Task 1."""

from __future__ import annotations

import unittest


def split_strings(words: list[str], separator: str) -> list[str]:
    """Split each string in words by separator and return non-empty parts."""
    result: list[str] = []
    for word in words:
        result.extend(part for part in word.split(separator) if part)
    return result


class TestSplitStrings(unittest.TestCase):
    """Unit tests for the split_strings function."""

    def test_examples(self) -> None:
        """Verify all challenge examples and edge cases."""
        cases: list[tuple[list[str], str, list[str]]] = [
            (
                ["one.two.three", "four.five", "six"],
                ".",
                ["one", "two", "three", "four", "five", "six"],
            ),
            (
                ["$perl$$", "$$raku$"],
                "$",
                ["perl", "raku"],
            ),
            (
                ["...", ".."],
                ".",
                [],
            ),
        ]
        for words, separator, expected in cases:
            with self.subTest(words=words, separator=separator):
                self.assertEqual(split_strings(words, separator), expected)


if __name__ == "__main__":
    unittest.main()
