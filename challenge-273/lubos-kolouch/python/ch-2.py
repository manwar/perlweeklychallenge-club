#!/usr/bin/env python3
"""B After A - Perl Weekly Challenge 273 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def b_after_a(text: str) -> bool:
    """Return True if there is a 'b' and no 'a' occurs after the first 'b'."""
    pos = text.find("b")
    if pos == -1:
        return False
    return "a" not in text[pos + 1 :]


class BAfterAExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertTrue(b_after_a("aabb"))

    def test_example_2(self) -> None:
        self.assertFalse(b_after_a("abab"))

    def test_example_3(self) -> None:
        self.assertFalse(b_after_a("aaa"))

    def test_example_4(self) -> None:
        self.assertTrue(b_after_a("bbb"))


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
    print(f"Output: {'true' if b_after_a(text) else 'false'}")


if __name__ == "__main__":
    main()

