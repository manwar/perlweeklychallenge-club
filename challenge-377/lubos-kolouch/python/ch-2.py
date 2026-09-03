#!/usr/bin/env python3
"""Perl Weekly Challenge 377 - Task 2: Prefix and Suffix.

Count pairs (i, j) with i < j where array[i] is both prefix and suffix of array[j].
"""

from __future__ import annotations

import unittest


def count_prefix_suffix_pairs(array: list[str]) -> int:
    """Return the total count of pairs (i, j) where array[i] is prefix and suffix of array[j].

    :param array: List of strings.
    :return: Count of valid pairs.
    """
    count = 0
    n = len(array)

    for i in range(n - 1):
        s1 = array[i]
        for j in range(i + 1, n):
            s2 = array[j]
            if s2.startswith(s1) and s2.endswith(s1):
                count += 1

    return count


class TestPrefixSuffix(unittest.TestCase):
    """Test cases for count_prefix_suffix_pairs."""

    def test_example_1(self) -> None:
        self.assertEqual(count_prefix_suffix_pairs(["a", "aba", "ababa", "aa"]), 4)

    def test_example_2(self) -> None:
        self.assertEqual(count_prefix_suffix_pairs(["pa", "papa", "ma", "mama"]), 2)

    def test_example_3(self) -> None:
        self.assertEqual(count_prefix_suffix_pairs(["abao", "ab"]), 0)

    def test_example_4(self) -> None:
        self.assertEqual(count_prefix_suffix_pairs(["abab", "abab"]), 1)

    def test_example_5(self) -> None:
        self.assertEqual(count_prefix_suffix_pairs(["ab", "abab", "ababab"]), 3)

    def test_example_6(self) -> None:
        self.assertEqual(count_prefix_suffix_pairs(["abc", "def", "ghij"]), 0)


if __name__ == "__main__":
    unittest.main()
