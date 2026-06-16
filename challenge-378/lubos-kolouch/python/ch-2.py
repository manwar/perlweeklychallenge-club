#!/usr/bin/env python3
"""Sum of Words - Perl Weekly Challenge 378 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def word_to_num(word: str) -> int:
    """Convert a word of 'a'-'j' characters to its corresponding numerical integer."""
    num_str = "".join(str(ord(char) - ord("a")) for char in word)
    return int(num_str)


def sum_of_words(str1: str, str2: str, str3: str) -> bool:
    """Return True if the sum of the first two converted strings equals the third, False otherwise."""
    return word_to_num(str1) + word_to_num(str2) == word_to_num(str3)


class SumOfWordsExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertTrue(sum_of_words("acb", "cba", "cdb"))

    def test_example_2(self) -> None:
        self.assertTrue(sum_of_words("aab", "aac", "ad"))

    def test_example_3(self) -> None:
        self.assertFalse(sum_of_words("bc", "je", "jg"))

    def test_example_4(self) -> None:
        self.assertTrue(sum_of_words("a", "aaaa", "aa"))

    def test_example_5(self) -> None:
        self.assertFalse(sum_of_words("c", "d", "h"))

    def test_example_6(self) -> None:
        self.assertTrue(sum_of_words("gfi", "hbf", "bdhd"))


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-2.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
