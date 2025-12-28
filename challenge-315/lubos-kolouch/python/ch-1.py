#!/usr/bin/env python3
"""Find Words - Perl Weekly Challenge 315 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def find_words(char: str, words: Sequence[str]) -> list[int]:
    """Return indices of words containing the given single character."""
    if len(char) != 1:
        raise ValueError("Expected a single character")
    return [idx for idx, word in enumerate(words) if char in word]


class FindWordsExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(find_words("e", ("the", "weekly", "challenge")), [0, 1, 2])

    def test_example_2(self) -> None:
        self.assertEqual(find_words("p", ("perl", "raku", "python")), [0, 2])

    def test_example_3(self) -> None:
        self.assertEqual(find_words("b", ("abc", "def", "bbb", "bcd")), [0, 2, 3])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) < 2:
        raise SystemExit("Usage: python3 ch-1.py <char> <word1> [word2...]")

    char = args[0]
    words = args[1:]
    result = find_words(char, words)
    quoted = '", "'.join(words)
    print(f'Input: @list = ("{quoted}")')
    print(f'       $char = "{char}"')
    print(f"Output: ({', '.join(map(str, result))})")


if __name__ == "__main__":
    main()
