#!/usr/bin/env python3
"""Uncommon Words - Perl Weekly Challenge 385 task 1."""

from __future__ import annotations

from collections import Counter
from collections.abc import Sequence
import sys
import unittest


def uncommon_words(sentence1: str, sentence2: str) -> list[str]:
    """Return list of all uncommon words across both sentences."""
    words = sentence1.split() + sentence2.split()
    counts = Counter(words)
    return sorted([word for word, count in counts.items() if count == 1])


class UncommonWordsExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(
            uncommon_words("apple banana apple", "banana orange"), ["orange"]
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            uncommon_words("cat dog", "bird fish"),
            ["bird", "cat", "dog", "fish"],
        )

    def test_example_3(self) -> None:
        self.assertEqual(
            uncommon_words("the quick brown fox", "the quick"),
            ["brown", "fox"],
        )

    def test_example_4(self) -> None:
        self.assertEqual(uncommon_words("hello", "hello"), [])

    def test_example_5(self) -> None:
        self.assertEqual(
            uncommon_words("blue blue red", "red green green yellow"),
            ["yellow"],
        )


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
