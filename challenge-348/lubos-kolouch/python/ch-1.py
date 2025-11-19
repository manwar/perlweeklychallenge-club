#!/usr/bin/env python3
"""String Alike - Perl Weekly Challenge 348 task 1."""

from __future__ import annotations

from typing import Final
from collections.abc import Sequence
import sys
import unittest

VOWELS: Final[frozenset[str]] = frozenset("aeiouAEIOU")


def is_string_alike(text: str) -> bool:
    """Return True when the halves of ``text`` share the same positive vowel count."""
    if len(text) % 2 != 0:
        raise ValueError("Expected an even-length string")

    half = len(text) // 2
    left = text[:half]
    right = text[half:]
    left_count = sum(1 for char in left if char in VOWELS)
    right_count = sum(1 for char in right if char in VOWELS)
    return left_count > 0 and left_count == right_count


class StringAlikeExamples(unittest.TestCase):
    """Example-based tests provided in the specification."""

    def test_example_1(self) -> None:
        self.assertFalse(is_string_alike("textbook"))

    def test_example_2(self) -> None:
        self.assertTrue(is_string_alike("book"))

    def test_example_3(self) -> None:
        self.assertTrue(is_string_alike("AbCdEfGh"))

    def test_example_4(self) -> None:
        self.assertFalse(is_string_alike("rhythmmyth"))

    def test_example_5(self) -> None:
        self.assertFalse(is_string_alike("UmpireeAudio"))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line launcher."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <even_length_string>")

    word = args[0]
    print(f'Input:  $str = "{word}"')
    result = "true" if is_string_alike(word) else "false"
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
