#!/usr/bin/env python3
"""Task 2 - Odd Letters checker for The Weekly Challenge #332."""
from __future__ import annotations

import unittest
from collections import Counter


def has_odd_letter_counts(text: str) -> bool:
    """
    Return True if every distinct letter in *text* appears an odd number of times.

    Args:
        text: A string containing only alphabetic characters.

    Returns:
        True when each distinct letter appears an odd number of times, otherwise False.

    Raises:
        ValueError: If *text* contains non-alphabetic characters or is empty.
    """
    if not text.isalpha():
        msg = f"Input must contain only alphabetic characters: {text!r}"
        raise ValueError(msg)
    normalized = text.lower()
    counts = Counter(normalized)
    return all(value % 2 == 1 for value in counts.values())


class OddLettersExamples(unittest.TestCase):
    """Unit tests derived from the supplied examples."""

    def test_example_1(self) -> None:
        self.assertFalse(has_odd_letter_counts("weekly"))

    def test_example_2(self) -> None:
        self.assertTrue(has_odd_letter_counts("perl"))

    def test_example_3(self) -> None:
        self.assertFalse(has_odd_letter_counts("challenge"))


if __name__ == "__main__":
    unittest.main()
