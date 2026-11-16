#!/usr/bin/env python3
"""Merge Strings - Perl Weekly Challenge 256 task 2."""

from __future__ import annotations

import unittest


def merge_strings(str1: str, str2: str) -> str:
    """Merge two strings by alternating characters and appending any remainder."""
    merged = "".join(a + b for a, b in zip(str1, str2))
    longer_part = str1[len(str2) :] if len(str1) > len(str2) else str2[len(str1) :]
    return merged + longer_part


class TestMergeStrings(unittest.TestCase):
    """Unit tests for merge_strings."""

    def test_example_1(self) -> None:
        """Verify Example 1."""
        self.assertEqual(merge_strings("abcd", "1234"), "a1b2c3d4")

    def test_example_2(self) -> None:
        """Verify Example 2."""
        self.assertEqual(merge_strings("abc", "12345"), "a1b2c345")

    def test_example_3(self) -> None:
        """Verify Example 3."""
        self.assertEqual(merge_strings("abcde", "123"), "a1b2c3de")


if __name__ == "__main__":
    unittest.main()
