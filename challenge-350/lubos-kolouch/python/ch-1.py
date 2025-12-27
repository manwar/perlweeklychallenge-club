#!/usr/bin/env python3
"""Good Substrings - Perl Weekly Challenge 350 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def good_substrings(text: str) -> int:
    """Return the number of length-3 substrings with all distinct characters."""
    if len(text) < 3:
        return 0

    count = 0
    for idx in range(len(text) - 2):
        chunk = text[idx : idx + 3]
        if len(set(chunk)) == 3:
            count += 1
    return count


class GoodSubstringsExamples(unittest.TestCase):
    """Example-based tests from the challenge specification."""

    def test_example_1(self) -> None:
        self.assertEqual(good_substrings("abcaefg"), 5)

    def test_example_2(self) -> None:
        self.assertEqual(good_substrings("xyzzabc"), 3)

    def test_example_3(self) -> None:
        self.assertEqual(good_substrings("aababc"), 1)

    def test_example_4(self) -> None:
        self.assertEqual(good_substrings("qwerty"), 4)

    def test_example_5(self) -> None:
        self.assertEqual(good_substrings("zzzaaa"), 0)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <string>")

    text = args[0]
    print(f'Input:  $str = "{text}"')
    print(f"Output: {good_substrings(text)}")


if __name__ == "__main__":
    main()
