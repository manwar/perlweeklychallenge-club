#!/usr/bin/env python3
"""Broken Keys - Perl Weekly Challenge 275 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def broken_keys(sentence: str, keys: Sequence[str]) -> int:
    """Count words that can be typed fully given broken keys (case-insensitive)."""
    broken = {k.lower() for k in keys}
    count = 0
    for word in sentence.split():
        if all(ch.lower() not in broken for ch in word):
            count += 1
    return count


class BrokenKeysExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(broken_keys("Perl Weekly Challenge", ("l", "a")), 0)

    def test_example_2(self) -> None:
        self.assertEqual(broken_keys("Perl and Raku", ("a",)), 1)

    def test_example_3(self) -> None:
        self.assertEqual(broken_keys("Well done Team PWC", ("l", "o")), 2)

    def test_example_4(self) -> None:
        self.assertEqual(broken_keys("The joys of polyglottism", ("T",)), 2)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) < 2:
        raise SystemExit("Usage: python3 ch-1.py <sentence> <keys...>")
    sentence = args[0]
    keys = args[1:]
    print(f'Input:  $sentence = "{sentence}", @keys = ({", ".join(repr(k) for k in keys)})')
    print(f"Output: {broken_keys(sentence, keys)}")


if __name__ == "__main__":
    main()

