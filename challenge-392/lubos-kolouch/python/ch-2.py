#!/usr/bin/env python3
"""Perl Weekly Challenge 392 - Task 2: Maximum Product of Word Lengths.

Return the maximum value of len(words[i]) * len(words[j]) where the two words
do not share common letters. Return 0 if no such pair exists.
"""

from __future__ import annotations

import unittest


def max_product(words: list[str]) -> int:
    """Return maximum len(words[i]) * len(words[j]) without common letters.

    Uses bitmasking (26 bits for letters a-z) to check disjoint character sets
    in O(1) bitwise AND time.

    :param words: List of input words.
    :return: Maximum product of lengths of two non-overlapping words.
    """
    if len(words) < 2:
        return 0

    # Precompute bitmasks and lengths
    masks: list[int] = []
    lengths: list[int] = []

    for w in words:
        mask = 0
        for char in w.lower():
            mask |= 1 << (ord(char) - ord("a"))
        masks.append(mask)
        lengths.append(len(w))

    max_prod = 0
    n = len(words)

    for i in range(n - 1):
        for j in range(i + 1, n):
            if (masks[i] & masks[j]) == 0:
                prod = lengths[i] * lengths[j]
                if prod > max_prod:
                    max_prod = prod

    return max_prod


class TestMaxProduct(unittest.TestCase):
    """Test cases for max_product."""

    def test_example_1(self) -> None:
        self.assertEqual(max_product(["a", "ab", "abc", "d", "de", "def"]), 9)

    def test_example_2(self) -> None:
        self.assertEqual(max_product(["a", "aa", "aaa", "aaaa"]), 0)

    def test_example_3(self) -> None:
        self.assertEqual(max_product(["meet", "app", "code", "sky", "bold"]), 16)

    def test_example_4(self) -> None:
        self.assertEqual(max_product(["a", "ab", "abc", "abcd", "efghi"]), 20)

    def test_example_5(self) -> None:
        self.assertEqual(max_product(["xyz", "w", "abcdefg", "hij"]), 21)


if __name__ == "__main__":
    unittest.main()
