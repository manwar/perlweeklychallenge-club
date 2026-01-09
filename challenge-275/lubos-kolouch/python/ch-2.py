#!/usr/bin/env python3
"""Replace Digits - Perl Weekly Challenge 275 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def replace_digits(text: str) -> str:
    """Replace each digit with last seen letter shifted forward by that digit."""
    last_letter: str | None = None
    out: list[str] = []
    for ch in text:
        if ch.isalpha():
            last_letter = ch
            out.append(ch)
            continue
        if ch.isdigit():
            if last_letter is None:
                raise ValueError("Digit without preceding letter")
            out.append(chr(ord(last_letter) + int(ch)))
            continue
        raise ValueError(f"Unexpected character: {ch}")
    return "".join(out)


class ReplaceDigitsExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(replace_digits("a1c1e1"), "abcdef")

    def test_example_2(self) -> None:
        self.assertEqual(replace_digits("a1b2c3d4"), "abbdcfdh")

    def test_example_3(self) -> None:
        self.assertEqual(replace_digits("b2b"), "bdb")

    def test_example_4(self) -> None:
        self.assertEqual(replace_digits("a16z"), "abgz")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <str>")
    text = args[0]
    print(f"Input:  $str = '{text}'")
    print(f"Output: '{replace_digits(text)}'")


if __name__ == "__main__":
    main()

