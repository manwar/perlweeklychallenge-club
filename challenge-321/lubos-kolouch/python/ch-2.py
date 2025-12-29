#!/usr/bin/env python3
"""Backspace Compare - Perl Weekly Challenge 321 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def _apply_backspaces(text: str) -> str:
    stack: list[str] = []
    for char in text:
        if char == "#":
            if stack:
                stack.pop()
        else:
            stack.append(char)
    return "".join(stack)


def backspace_compare(first: str, second: str) -> bool:
    """Return True if the strings match after treating '#' as backspace."""
    return _apply_backspaces(first) == _apply_backspaces(second)


class BackspaceCompareExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertTrue(backspace_compare("ab#c", "ad#c"))

    def test_example_2(self) -> None:
        self.assertTrue(backspace_compare("ab##", "a#b#"))

    def test_example_3(self) -> None:
        self.assertFalse(backspace_compare("a#b", "c"))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-2.py <str1> <str2>")

    first, second = args
    result = "true" if backspace_compare(first, second) else "false"
    print(f'Input: $str1 = "{first}"')
    print(f'       $str2 = "{second}"')
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
