#!/usr/bin/env python3
"""Perl Weekly Challenge 004 Task 2: match words buildable from letters."""

from __future__ import annotations

from collections import Counter
import sys
import unittest


def can_build_word(word: str, letters: str) -> bool:
    """Return True if `word` can be built from `letters` (case-insensitive)."""
    need = Counter(word.lower())
    available = Counter(letters.lower())
    return all(need[ch] <= available[ch] for ch in need)


def matching_words(letters: str, words: list[str]) -> list[str]:
    """Return words that can be built from `letters`, preserving input order."""
    return [word for word in words if can_build_word(word, letters)]


class Task2SpecRuleTests(unittest.TestCase):
    """Tests derived directly from challenge rules."""

    def test_each_letter_only_once(self) -> None:
        self.assertEqual(matching_words("abc", ["cab", "baa", "dad"]), ["cab"])

    def test_case_insensitive_and_duplicates(self) -> None:
        self.assertEqual(
            matching_words("aAbB", ["ab", "bA", "aba", "BBa"]),
            ["ab", "bA", "aba", "BBa"],
        )


def _read_words(path: str | None) -> list[str]:
    """Read one-word-per-line input either from a file or stdin."""
    if path is None:
        return [line.strip() for line in sys.stdin if line.strip()]

    with open(path, encoding="utf-8") as handle:
        return [line.strip() for line in handle if line.strip()]


def main(argv: list[str] | None = None) -> None:
    """CLI entry point."""
    args = sys.argv[1:] if argv is None else argv
    if args and args[0] == "--test":
        unittest.main(argv=[sys.argv[0]])
        return

    if not args:
        raise SystemExit(f"Usage: {sys.argv[0]} <letters> [words-file]")

    letters = args[0]
    words_file = args[1] if len(args) > 1 else None

    for word in matching_words(letters, _read_words(words_file)):
        print(word)


if __name__ == "__main__":
    main()
