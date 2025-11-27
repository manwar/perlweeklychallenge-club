#!/usr/bin/env python3
"""
Task: Consecutive One (Weekly Challenge 325)

Return the longest run of consecutive 1s in a binary array.
"""
from __future__ import annotations

import unittest
from typing import List


def consecutive_one(binary: List[int]) -> int:
    best = current = 0
    for bit in binary:
        if bit == 1:
            current += 1
            best = max(best, current)
        else:
            current = 0
    return best


class ConsecutiveOneTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(consecutive_one([0, 1, 1, 0, 1, 1, 1]), 3)
        self.assertEqual(consecutive_one([0, 0, 0, 0]), 0)
        self.assertEqual(consecutive_one([1, 0, 1, 0, 1, 1]), 2)


if __name__ == "__main__":
    unittest.main()
