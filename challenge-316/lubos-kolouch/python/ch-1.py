#!/usr/bin/env python3
"""Circular - Perl Weekly Challenge 316 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def is_circular(words: Sequence[str]) -> bool:
    """Return True if last char of each word matches first char of the next."""
    if len(words) <= 1:
        return True
    return all(a[-1] == b[0] for a, b in zip(words, words[1:]))


class CircularExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertTrue(is_circular(("perl", "loves", "scala")))

    def test_example_2(self) -> None:
        self.assertFalse(is_circular(("love", "the", "programming")))

    def test_example_3(self) -> None:
        self.assertTrue(is_circular(("java", "awk", "kotlin", "node.js")))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    quoted = '", "'.join(args)
    result = "true" if is_circular(args) else "false"
    print(f'Input:  @list = ("{quoted}")')
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
