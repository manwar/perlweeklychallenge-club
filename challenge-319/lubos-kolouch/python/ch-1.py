#!/usr/bin/env python3
"""Word Count - Perl Weekly Challenge 319 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


VOWELS = set("aeiou")


def word_count(words: Sequence[str]) -> int:
    """Count words that start with a vowel or end with a vowel."""
    count = 0
    for word in words:
        if not word:
            continue
        lower = word.lower()
        if lower[0] in VOWELS or lower[-1] in VOWELS:
            count += 1
    return count


class WordCountExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(word_count(("unicode", "xml", "raku", "perl")), 2)

    def test_example_2(self) -> None:
        self.assertEqual(word_count(("the", "weekly", "challenge")), 2)

    def test_example_3(self) -> None:
        self.assertEqual(word_count(("perl", "python", "postgres")), 0)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    quoted = '", "'.join(args)
    print(f'Input:  @list = ("{quoted}")')
    print(f"Output: {word_count(args)}")


if __name__ == "__main__":
    main()
