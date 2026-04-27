#!/usr/bin/env python3
"""
Task: Missing Letter (Weekly Challenge 371)

Identify the missing letter in a sequence of five lowercase letters.
The sequence follows a constant or alternating step pattern.
"""

from __future__ import annotations

import unittest


def find_missing_letter(letters: list[str]) -> str:
    """Return the missing letter in the sequence."""

    # Try all possible letters for '?'
    for cand_char in (chr(c) for c in range(ord("a"), ord("z") + 1)):
        current_letters = [cand_char if ch == "?" else ch for ch in letters]
        indices = [ord(ch) - ord("a") + 1 for ch in current_letters]

        diffs = [indices[i + 1] - indices[i] for i in range(4)]

        # Check if constant step
        if all(d == diffs[0] for d in diffs):
            return cand_char

        # Check if alternating pattern
        if diffs[0] == diffs[2] and diffs[1] == diffs[3]:
            return cand_char

    return "?"


class TestMissingLetter(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(find_missing_letter(["a", "c", "e", "?", "i"]), "g")
        self.assertEqual(find_missing_letter(["a", "d", "e", "g", "?"]), "h")
        self.assertEqual(find_missing_letter(["?", "b", "d", "f", "h"]), "a")
        self.assertEqual(find_missing_letter(["a", "?", "e", "g", "i"]), "c")
        self.assertEqual(find_missing_letter(["a", "b", "?", "e", "f"]), "d")
        self.assertEqual(find_missing_letter(["a", "c", "f", "h", "?"]), "k")


if __name__ == "__main__":
    unittest.main()
