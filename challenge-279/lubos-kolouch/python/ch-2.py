#!/usr/bin/env python3
"""Split String - Perl Weekly Challenge 279 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


VOWELS = set("aeiou")


def split_string(text: str) -> bool:
    """Return True if text can be split into 2 non-empty parts with equal vowels."""
    if len(text) < 2:
        return False

    total = sum(1 for ch in text.lower() if ch in VOWELS)
    if total % 2 == 1:
        return False

    target = total // 2
    if target == 0:
        return True

    count = 0
    for i, ch in enumerate(text[:-1]):
        if ch.lower() in VOWELS:
            count += 1
        if count == target:
            return True
    return False


class SplitStringExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertFalse(split_string("perl"))

    def test_example_2(self) -> None:
        self.assertTrue(split_string("book"))

    def test_example_3(self) -> None:
        self.assertTrue(split_string("good morning"))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    text = " ".join(args)
    print(f'Input:  $str = "{text}"')
    print(f"Output: {'true' if split_string(text) else 'false'}")


if __name__ == "__main__":
    main()

