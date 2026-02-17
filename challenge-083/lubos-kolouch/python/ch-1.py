#!/usr/bin/env python3
"""
Perl Weekly Challenge 083 - Task 1: Words Length

You are given a sentence.

Return the total length of all words except the first and the last word.
Words are separated by whitespace (and there may be multiple spaces).
"""

from __future__ import annotations

from typing import Sequence


def words_length(sentence: str) -> int:
    """Return total length of words excluding the first and last."""
    words = sentence.split()
    if len(words) <= 2:
        return 0
    return sum(len(w) for w in words[1:-1])


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    print(words_length(" ".join(argv)))


def _run_tests() -> None:
    import unittest

    class TestChallenge083Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(words_length("The Weekly Challenge"), 6)

        def test_example_2(self) -> None:
            self.assertEqual(words_length("The purpose of our lives is to be happy"), 23)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge083Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

