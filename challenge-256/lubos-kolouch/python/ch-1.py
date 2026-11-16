#!/usr/bin/env python3
"""Maximum Pairs - Perl Weekly Challenge 256 task 1."""

from __future__ import annotations

import unittest


def max_pairs(words: list[str] | tuple[str, ...]) -> int:
    """Return the maximum number of reverse pairs in the distinct word list."""
    word_set = set(words)
    count = sum(1 for word in words if word[::-1] != word and word[::-1] in word_set)
    return count // 2


class TestMaxPairs(unittest.TestCase):
    """Unit tests for max_pairs."""

    def test_example_1(self) -> None:
        """Verify Example 1."""
        self.assertEqual(max_pairs(["ab", "de", "ed", "bc"]), 1)

    def test_example_2(self) -> None:
        """Verify Example 2."""
        self.assertEqual(max_pairs(["aa", "ba", "cd", "ed"]), 0)

    def test_example_3(self) -> None:
        """Verify Example 3."""
        self.assertEqual(max_pairs(["uv", "qp", "st", "vu", "mn", "pq"]), 2)


if __name__ == "__main__":
    unittest.main()
