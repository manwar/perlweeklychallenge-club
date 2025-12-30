#!/usr/bin/env python3
"""Count Asterisks - Perl Weekly Challenge 280 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def count_asterisks(text: str) -> int:
    """Return number of '*' outside paired '|' segments."""
    inside = False
    count = 0
    for ch in text:
        if ch == "|":
            inside = not inside
            continue
        if not inside and ch == "*":
            count += 1
    return count


class CountAsterisksExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(count_asterisks("p|*e*rl|w**e|*ekly|"), 2)

    def test_example_2(self) -> None:
        self.assertEqual(count_asterisks("perl"), 0)

    def test_example_3(self) -> None:
        self.assertEqual(count_asterisks("th|ewe|e**|k|l***ych|alleng|e"), 5)


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
    print(f"Output: {count_asterisks(text)}")


if __name__ == "__main__":
    main()

