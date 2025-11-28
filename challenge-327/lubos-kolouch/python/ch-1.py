#!/usr/bin/env python3
"""
Task: Missing Integers (Weekly Challenge 327)

Given n integers, return the missing integers from the range 1..n.
"""
from __future__ import annotations

from typing import List
import unittest


def missing_integers(ints: List[int]) -> List[int]:
    """Return integers missing from 1..n (n == len(ints))."""
    n = len(ints)
    present = set(ints)
    return [i for i in range(1, n + 1) if i not in present]


class MissingIntegersTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(missing_integers([1, 2, 1, 3, 2, 5]), [4, 6])
        self.assertEqual(missing_integers([1, 1, 1]), [2, 3])
        self.assertEqual(missing_integers([2, 2, 1]), [3])


if __name__ == "__main__":
    unittest.main()
