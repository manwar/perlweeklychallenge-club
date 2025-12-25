#!/usr/bin/env python3
"""Max Words - Perl Weekly Challenge 353 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def max_words(sentences: Sequence[str]) -> int:
    """
    Return the maximum number of whitespace-separated words in any sentence.

    An empty sentence counts as having 0 words.
    """
    best = 0
    for sentence in sentences:
        count = len(sentence.split())
        if count > best:
            best = count
    return best


class MaxWordsExamples(unittest.TestCase):
    """Example-based tests from the challenge specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            max_words(("Hello world", "This is a test", "Perl is great")), 4
        )

    def test_example_2(self) -> None:
        self.assertEqual(max_words(("Single",)), 1)

    def test_example_3(self) -> None:
        self.assertEqual(
            max_words(
                (
                    "Short",
                    "This sentence has seven words in total",
                    "A B C",
                    "Just four words here",
                )
            ),
            7,
        )

    def test_example_4(self) -> None:
        self.assertEqual(max_words(("One", "Two parts", "Three part phrase", "")), 3)

    def test_example_5(self) -> None:
        self.assertEqual(
            max_words(
                (
                    "The quick brown fox jumps over the lazy dog",
                    "A",
                    "She sells seashells by the seashore",
                    "To be or not to be that is the question",
                )
            ),
            10,
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    quoted = '", "'.join(args)
    print(f'Input:  @sentences = ("{quoted}")')
    print(f"Output: {max_words(args)}")


if __name__ == "__main__":
    main()
