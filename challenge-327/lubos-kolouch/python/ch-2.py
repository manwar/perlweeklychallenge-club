#!/usr/bin/env python3
"""
Task: MAD (Weekly Challenge 327)

Given distinct integers, find all pairs with the minimum absolute
difference. Return pairs sorted.
"""
from __future__ import annotations

from typing import List, Tuple
import unittest


def mad_pairs(ints: List[int]) -> List[Tuple[int, int]]:
    """Return pairs of values with minimum absolute difference."""
    if len(ints) < 2:
        return []
    sorted_ints = sorted(ints)
    min_diff = float("inf")
    result: List[Tuple[int, int]] = []
    for a, b in zip(sorted_ints, sorted_ints[1:]):
        diff = b - a
        if diff < min_diff:
            min_diff = diff
            result = [(a, b)]
        elif diff == min_diff:
            result.append((a, b))
    return result


class MadPairsTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(mad_pairs([4, 1, 2, 3]), [(1, 2), (2, 3), (3, 4)])
        self.assertEqual(mad_pairs([1, 3, 7, 11, 15]), [(1, 3)])
        self.assertEqual(mad_pairs([1, 5, 3, 8]), [(1, 3), (3, 5)])


if __name__ == "__main__":
    unittest.main()
