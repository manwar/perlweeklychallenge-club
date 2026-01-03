#!/usr/bin/env python3
"""Reverse Word - Perl Weekly Challenge 278 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def reverse_word(word: str, char: str) -> str:
    """Sort prefix up to first occurrence of char; otherwise return word."""
    if len(char) != 1:
        raise ValueError("Expected a single character")

    pos = word.find(char)
    if pos == -1:
        return word

    prefix = word[: pos + 1]
    rest = word[pos + 1 :]
    return "".join(sorted(prefix)) + rest


class ReverseWordExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(reverse_word("challenge", "e"), "acehllnge")

    def test_example_2(self) -> None:
        self.assertEqual(reverse_word("programming", "a"), "agoprrmming")

    def test_example_3(self) -> None:
        self.assertEqual(reverse_word("champion", "b"), "champion")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-2.py <word> <char>")
    word, char = args
    print(f'Input:  $str = "{word}", $char = "{char}"')
    print(f'Output: "{reverse_word(word, char)}"')


if __name__ == "__main__":
    main()

