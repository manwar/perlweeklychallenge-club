#!/usr/bin/env python3
"""Reverse Letters - Perl Weekly Challenge 313 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def reverse_letters(text: str) -> str:
    """Reverse only alphabetic characters, keeping other characters in place."""
    chars = list(text)
    left = 0
    right = len(chars) - 1

    while left < right:
        while left < right and not chars[left].isalpha():
            left += 1
        while left < right and not chars[right].isalpha():
            right -= 1
        if left < right:
            chars[left], chars[right] = chars[right], chars[left]
            left += 1
            right -= 1
    return "".join(chars)


class ReverseLettersExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(reverse_letters("p-er?l"), "l-re?p")

    def test_example_2(self) -> None:
        self.assertEqual(reverse_letters("wee-k!L-y"), "yLk-e!e-w")

    def test_example_3(self) -> None:
        self.assertEqual(reverse_letters("_c-!h_all-en!g_e"), "_e-!g_nel-la!h_c")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <string>")

    text = args[0]
    print(f'Input: $str = "{text}"')
    print(f'Output: "{reverse_letters(text)}"')


if __name__ == "__main__":
    main()
