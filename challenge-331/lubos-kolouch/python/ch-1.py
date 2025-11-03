#!/usr/bin/env python3
"""
Task 1: Last Word

Determine the length of the final word within a string, trimming any
whitespace that may precede or follow the words. Words are contiguous
sequences of non-whitespace characters.
"""
from __future__ import annotations

import unittest


def last_word_length(text: str) -> int:
    """
    Return the length of the last word found in `text`.

    Args:
        text: Input string that may contain leading/trailing whitespace.

    Returns:
        Length of the final word if present, otherwise zero.
    """
    words: list[str] = text.split()
    return len(words[-1]) if words else 0


class LastWordTests(unittest.TestCase):

    def test_example_1(self) -> None:
        self.assertEqual(last_word_length("The Weekly Challenge"), 9)

    def test_example_2(self) -> None:
        self.assertEqual(last_word_length("   Hello   World    "), 5)

    def test_example_3(self) -> None:
        self.assertEqual(last_word_length("Let's begin the fun"), 3)


if __name__ == "__main__":
    unittest.main()
