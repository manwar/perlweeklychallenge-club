#!/usr/bin/env python3
"""Changing Keys - Perl Weekly Challenge 282 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def changing_keys(text: str) -> int:
    """Return the number of key changes in text, ignoring case."""
    s = text.lower()
    if len(s) <= 1:
        return 0

    changes = 0
    prev = s[0]
    for ch in s[1:]:
        if ch != prev:
            changes += 1
            prev = ch
    return changes


class ChangingKeysExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(changing_keys("pPeERrLl"), 3)

    def test_example_2(self) -> None:
        self.assertEqual(changing_keys("rRr"), 0)

    def test_example_3(self) -> None:
        self.assertEqual(changing_keys("GoO"), 1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <str>")
    text = args[0]
    print(f'Input:  $str = "{text}"')
    print(f"Output: {changing_keys(text)}")


if __name__ == "__main__":
    main()

