#!/usr/bin/env python3
"""
Largest Substring - Perl Weekly Challenge 372 task 2.
"""

from __future__ import annotations

import sys
import unittest
from collections.abc import Sequence


def largest_substring(text: str) -> int:
    """
    Returns the length of the largest substring between two equal characters
    excluding the two characters. Return -1 if no such substring exists.
    """
    first_pos: dict[str, int] = {}
    max_len = -1

    for i, char in enumerate(text):
        if char in first_pos:
            length = i - first_pos[char] - 1
            if length > max_len:
                max_len = length
        else:
            first_pos[char] = i

    return max_len


class LargestSubstringExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(largest_substring("aaaaa"), 3)

    def test_example_2(self) -> None:
        self.assertEqual(largest_substring("abcdeba"), 5)

    def test_example_3(self) -> None:
        self.assertEqual(largest_substring("abbc"), 0)

    def test_example_4(self) -> None:
        self.assertEqual(largest_substring("abcaacbc"), 4)

    def test_example_5(self) -> None:
        self.assertEqual(largest_substring("laptop"), 2)

    def test_example_6(self) -> None:
        self.assertEqual(largest_substring("abc"), -1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    text = args[0]
    print(largest_substring(text))


if __name__ == "__main__":
    main()
