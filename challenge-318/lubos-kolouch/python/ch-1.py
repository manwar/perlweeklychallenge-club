#!/usr/bin/env python3
"""Group Position - Perl Weekly Challenge 318 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import re
import sys
import unittest


def group_position(text: str) -> list[str]:
    """
    Return groups of >=3 identical consecutive letters.

    The examples return the group substrings (not their indices).
    """
    return [match.group(0) for match in re.finditer(r"([a-z])\1{2,}", text)]


class GroupPositionExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(group_position("abccccd"), ["cccc"])

    def test_example_2(self) -> None:
        self.assertEqual(group_position("aaabcddddeefff"), ["aaa", "dddd", "fff"])

    def test_example_3(self) -> None:
        self.assertEqual(group_position("abcdd"), [])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <string>")

    text = args[0]
    groups = group_position(text)
    print(f'Input: $str = "{text}"')
    if groups:
        rendered = '", "'.join(groups)
        print(f'Output: "{rendered}"')
    else:
        print('Output: ""')


if __name__ == "__main__":
    main()
