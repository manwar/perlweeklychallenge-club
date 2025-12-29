#!/usr/bin/env python3
"""Broken Keys - Perl Weekly Challenge 313 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def is_long_pressed(name: str, typed: str) -> bool:
    """Return True if typed could be produced from name via long-pressing keys."""
    if len(typed) < len(name):
        return False

    i = 0
    j = 0
    while j < len(typed):
        if i < len(name) and name[i] == typed[j]:
            i += 1
            j += 1
        elif j > 0 and typed[j] == typed[j - 1]:
            j += 1
        else:
            return False
    return i == len(name)


class BrokenKeysExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertTrue(is_long_pressed("perl", "perrrl"))

    def test_example_2(self) -> None:
        self.assertTrue(is_long_pressed("raku", "rrakuuuu"))

    def test_example_3(self) -> None:
        self.assertFalse(is_long_pressed("python", "perl"))

    def test_example_4(self) -> None:
        self.assertTrue(is_long_pressed("coffeescript", "cofffeescccript"))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-1.py <name> <typed>")

    name, typed = args
    result = "true" if is_long_pressed(name, typed) else "false"
    print(f'Input: $name = "{name}", $typed = "{typed}"')
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
