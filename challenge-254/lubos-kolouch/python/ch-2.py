#!/usr/bin/env python3
"""Reverse Vowels - Perl Weekly Challenge 254, Task 2."""

from __future__ import annotations

import unittest


def reverse_vowels(s: str) -> str:
    """Return s with all vowels reversed while preserving original vowel case."""
    vowels = set("aeiouAEIOU")
    reversed_vowels: list[str] = [char for char in s if char in vowels][::-1]
    reversed_iter = iter(reversed_vowels)

    result: list[str] = []
    for char in s:
        if char in vowels:
            replacement = next(reversed_iter)
            result.append(
                replacement.upper() if char.isupper() else replacement.lower()
            )
        else:
            result.append(char)

    return "".join(result)


class TestReverseVowels(unittest.TestCase):
    """Unit tests for the reverse_vowels function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[str, str]] = [
            ("Raku", "Ruka"),
            ("Perl", "Perl"),
            ("Julia", "Jaliu"),
            ("Uiua", "Auiu"),
        ]
        for text, expected in cases:
            with self.subTest(text=text):
                self.assertEqual(reverse_vowels(text), expected)


if __name__ == "__main__":
    unittest.main()
