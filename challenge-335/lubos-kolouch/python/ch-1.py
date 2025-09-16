#!/usr/bin/env python3
"""The Weekly Challenge 335 Task 1: Common Characters."""
from collections import Counter
import unittest

WordList = list[str]


def common_characters(words: WordList) -> list[str]:
    """Return characters that appear in every word, keeping duplicate counts."""
    if not words:
        return []

    common = Counter(words[0])
    for word in words[1:]:
        common &= Counter(word)
    result: list[str] = []
    for char in sorted(common.keys()):
        result.extend([char] * common[char])
    return result


class TestCommonCharacters(unittest.TestCase):
    """Unit tests for the provided challenge examples."""

    def test_example1(self) -> None:
        self.assertEqual(common_characters(["bella", "label", "roller"]),
                         ["e", "l", "l"])

    def test_example2(self) -> None:
        self.assertEqual(common_characters(["cool", "lock", "cook"]),
                         ["c", "o"])

    def test_example3(self) -> None:
        self.assertEqual(common_characters(["hello", "world", "pole"]),
                         ["l", "o"])

    def test_example4(self) -> None:
        self.assertEqual(common_characters(["abc", "def", "ghi"]), [])

    def test_example5(self) -> None:
        self.assertEqual(common_characters(["aab", "aac", "aaa"]), ["a", "a"])


if __name__ == "__main__":
    unittest.main()
