#!/usr/bin/env python3
"""
Perl Weekly Challenge 131 - Task 2: Find Pairs

You are given:
  - a string of delimiter pairs (opening/closing alternating characters)
  - a string to search

Return two strings:
  1) characters from the search string that match any opening character
  2) characters from the search string that match any closing character
"""

from __future__ import annotations

from typing import Sequence, Tuple


def find_pairs(delimiter_pairs: str, search: str) -> Tuple[str, str]:
    """Return (open_matches, close_matches) based on delimiter_pairs."""
    opening = set(delimiter_pairs[0::2])
    closing = set(delimiter_pairs[1::2])

    open_out = "".join(ch for ch in search if ch in opening)
    close_out = "".join(ch for ch in search if ch in closing)
    return open_out, close_out


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit(f"Usage: {__file__}  # runs tests only")


def _run_tests() -> None:
    import unittest

    class TestChallenge131Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            pairs = '""[]()'
            s = '"I like (parens) and the Apple ][+" they said.'
            self.assertEqual(find_pairs(pairs, s), ('"(["', '")]"'))

        def test_example_2(self) -> None:
            pairs = "**//<>"
            s = "/* This is a comment (in some languages) */ <could be a tag>"
            self.assertEqual(find_pairs(pairs, s), ("/**/<", "/**/>"))

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge131Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
