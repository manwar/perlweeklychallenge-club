#!/usr/bin/env python3
"""Greatest English Letter - Perl Weekly Challenge 264 Task 1."""

from __future__ import annotations

import unittest


def greatest_english_letter(s: str) -> str:
    """Return the greatest English letter occurring in both lower and upper case.

    A letter is considered greater if it appears later in the English alphabet.
    If no letter appears in both cases, an empty string is returned.
    """
    lower_set = {c.lower() for c in s if c.islower()}
    upper_set = {c.lower() for c in s if c.isupper()}

    common_letters = lower_set & upper_set
    greatest_letter = max(common_letters, default="")
    return greatest_letter.upper()


class TestGreatestEnglishLetter(unittest.TestCase):
    """Unit tests for greatest_english_letter."""

    def test_example_1(self) -> None:
        """Test Example 1: PeRlwEeKLy -> L."""
        self.assertEqual(greatest_english_letter("PeRlwEeKLy"), "L")

    def test_example_2(self) -> None:
        """Test Example 2: ChaLlenge -> L."""
        self.assertEqual(greatest_english_letter("ChaLlenge"), "L")

    def test_example_3(self) -> None:
        """Test Example 3: The -> empty string."""
        self.assertEqual(greatest_english_letter("The"), "")

    def test_empty_string(self) -> None:
        """Test empty string returns empty string."""
        self.assertEqual(greatest_english_letter(""), "")

    def test_multiple_matches_picks_greatest(self) -> None:
        """Test string with multiple valid letters returns alphabetically greatest."""
        self.assertEqual(greatest_english_letter("aAbBcCzZ"), "Z")


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
