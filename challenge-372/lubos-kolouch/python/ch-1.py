#!/usr/bin/env python3
"""
Rearrange Spaces - Perl Weekly Challenge 372 task 1.
"""

from __future__ import annotations

import sys
import unittest
from collections.abc import Sequence


def rearrange_spaces(text: str) -> str:
    """
    Rearrange spaces so that there is an equal number of spaces between every pair
    of adjacent words and that number is maximised. Extra spaces go at the end.
    """
    num_spaces = text.count(" ")
    words = text.split()
    num_words = len(words)

    if num_words == 1:
        return words[0] + (" " * num_spaces)

    num_gaps = num_words - 1
    spaces_per_gap = num_spaces // num_gaps
    remainder = num_spaces % num_gaps

    return (" " * spaces_per_gap).join(words) + (" " * remainder)


class RearrangeSpacesExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(rearrange_spaces("  challenge  "), "challenge    ")

    def test_example_2(self) -> None:
        self.assertEqual(rearrange_spaces("coding  is  fun"), "coding  is  fun")

    def test_example_3(self) -> None:
        self.assertEqual(rearrange_spaces("a b c  d"), "a b c d ")

    def test_example_4(self) -> None:
        self.assertEqual(rearrange_spaces("  team      pwc  "), "team          pwc")

    def test_example_5(self) -> None:
        self.assertEqual(
            rearrange_spaces("   the  weekly  challenge  "),
            "the    weekly    challenge ",
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    text = " ".join(args)
    print(f'"{rearrange_spaces(text)}"')


if __name__ == "__main__":
    main()
