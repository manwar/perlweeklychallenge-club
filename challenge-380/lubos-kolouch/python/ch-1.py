#!/usr/bin/env python3
"""Sum of Frequencies - Perl Weekly Challenge 380 task 1."""

from __future__ import annotations

from collections.abc import Sequence
from collections import Counter
import sys
import unittest


def sum_of_frequencies(s: str) -> int:
    """Return the sum of the maximum vowel and consonant frequencies."""
    vowels_set = set("aeiou")
    vowel_counts: Counter[str] = Counter()
    consonant_counts: Counter[str] = Counter()

    for char in s.lower():
        if char.isalpha() and "a" <= char <= "z":
            if char in vowels_set:
                vowel_counts[char] += 1
            else:
                consonant_counts[char] += 1

    max_vowel = max(vowel_counts.values()) if vowel_counts else 0
    max_consonant = max(consonant_counts.values()) if consonant_counts else 0

    return max_vowel + max_consonant


class SumOfFrequenciesExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(sum_of_frequencies("banana"), 5)

    def test_example_2(self) -> None:
        self.assertEqual(sum_of_frequencies("teestett"), 7)

    def test_example_3(self) -> None:
        self.assertEqual(sum_of_frequencies("aeiouuaa"), 3)

    def test_example_4(self) -> None:
        self.assertEqual(sum_of_frequencies("rhythm"), 2)

    def test_example_5(self) -> None:
        self.assertEqual(sum_of_frequencies("x"), 1)


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-1.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
