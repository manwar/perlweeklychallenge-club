#!/usr/bin/env python3
"""Power String - Perl Weekly Challenge 349 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def power_string(text: str) -> int:
    """Return the maximum run length of a repeated character inside ``text``."""
    if not text:
        raise ValueError("Expected a non-empty string")

    best = 0
    current = 0
    previous = ""

    for char in text:
        if char == previous:
            current += 1
        else:
            previous = char
            current = 1
        if current > best:
            best = current
    return best


class PowerStringExamples(unittest.TestCase):
    """Example-based tests provided in the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(power_string("textbook"), 2)

    def test_example_2(self) -> None:
        self.assertEqual(power_string("aaaaa"), 5)

    def test_example_3(self) -> None:
        self.assertEqual(power_string("hoorayyy"), 3)

    def test_example_4(self) -> None:
        self.assertEqual(power_string("x"), 1)

    def test_example_5(self) -> None:
        self.assertEqual(power_string("aabcccddeeffffghijjk"), 4)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <string>")

    word = args[0]
    print(f'Input:  $str = "{word}"')
    print(f"Output: {power_string(word)}")


if __name__ == "__main__":
    main()
