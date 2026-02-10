#!/usr/bin/env python3
"""
Perl Weekly Challenge 360 - Task 2: Word Sorter

You are given a sentence.

Order words alphabetically (case-insensitive) but keep the words themselves
unchanged. Output uses single spaces between words.
"""

from __future__ import annotations

from typing import Sequence


def word_sorter(sentence: str) -> str:
    """Return the sentence with words sorted alphabetically (case-insensitive)."""
    words = sentence.split()
    words_sorted = sorted(words, key=str.lower)
    return " ".join(words_sorted)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    print(word_sorter(" ".join(argv)))


def _run_tests() -> None:
    import unittest

    class TestChallenge360Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(word_sorter("The quick brown fox"), "brown fox quick The")

        def test_example_2(self) -> None:
            self.assertEqual(
                word_sorter("Hello    World!   How   are you?"),
                "are Hello How World! you?",
            )

        def test_example_3(self) -> None:
            self.assertEqual(word_sorter("Hello"), "Hello")

        def test_example_4(self) -> None:
            self.assertEqual(
                word_sorter("Hello, World! How are you?"),
                "are Hello, How World! you?",
            )

        def test_example_5(self) -> None:
            self.assertEqual(
                word_sorter("I have 2 apples and 3 bananas!"),
                "2 3 and apples bananas! have I",
            )

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge360Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

