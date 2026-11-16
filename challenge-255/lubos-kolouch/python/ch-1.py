#!/usr/bin/env python3
"""Odd Character - Perl Weekly Challenge 255 task 1."""

from __future__ import annotations

from collections import Counter
import unittest


def find_odd_character(s: str, t: str) -> str:
    """Return the additional character present in string t compared to s."""
    count_s = Counter(s)
    count_t = Counter(t)

    for char, count in count_t.items():
        if count > count_s.get(char, 0):
            return char

    return ""


class TestFindOddCharacter(unittest.TestCase):
    """Unit tests for find_odd_character."""

    def test_example_1(self) -> None:
        """Verify Example 1."""
        self.assertEqual(find_odd_character("Perl", "Preel"), "e")

    def test_example_2(self) -> None:
        """Verify Example 2."""
        self.assertEqual(find_odd_character("Weekly", "Weeakly"), "a")

    def test_example_3(self) -> None:
        """Verify Example 3."""
        self.assertEqual(find_odd_character("Box", "Boxy"), "y")


if __name__ == "__main__":
    unittest.main()
