#!/usr/bin/env python3
"""Odd String - Perl Weekly Challenge 193 task 2."""

from __future__ import annotations

from collections import Counter
from collections.abc import Sequence
import sys
import unittest


def _sig(s: str) -> tuple[int, ...]:
    vals = [ord(ch) - ord("a") for ch in s]
    return tuple(vals[i + 1] - vals[i] for i in range(len(vals) - 1))


def odd_string(strings: Sequence[str]) -> str:
    """Return the string whose difference array is unique."""
    if len(strings) < 3:
        raise ValueError("Expected at least 3 strings")

    sigs = [_sig(s) for s in strings]
    counts = Counter(sigs)
    for s, sig in zip(strings, sigs):
        if counts[sig] == 1:
            return s
    raise ValueError("No unique string found")


class OddStringExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(odd_string(("adc", "wzy", "abc")), "abc")

    def test_example_2(self) -> None:
        self.assertEqual(odd_string(("aaa", "bob", "ccc", "ddd")), "bob")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    print(f"Input:  @s = ({', '.join(repr(x) for x in args)})")
    print(f'Output: "{odd_string(args)}"')


if __name__ == "__main__":
    main()

