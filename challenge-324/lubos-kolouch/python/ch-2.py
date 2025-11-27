#!/usr/bin/env python3
"""
Task: Total XOR (Weekly Challenge 324)

Return the sum of XOR values for every non-empty subset of the list.
"""
from __future__ import annotations

from typing import List
import unittest


def total_xor(ints: List[int]) -> int:
    n = len(ints)
    total = 0
    for mask in range(1, 1 << n):
        xor_val = 0
        for i in range(n):
            if mask & (1 << i):
                xor_val ^= ints[i]
        total += xor_val
    return total


class TotalXorTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(total_xor([1, 3]), 6)
        self.assertEqual(total_xor([5, 1, 6]), 28)
        self.assertEqual(total_xor([3, 4, 5, 6, 7, 8]), 480)


if __name__ == "__main__":
    unittest.main()
