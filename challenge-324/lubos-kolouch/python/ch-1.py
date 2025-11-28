#!/usr/bin/env python3
"""
Task: 2D Array (Weekly Challenge 324)

Reshape a flat list into r x c rows filled row-wise.
"""
from __future__ import annotations

from typing import List
import unittest


def make_2d_array(r: int, c: int, ints: List[int]) -> List[List[int]]:
    """Return a 2D array with r rows and c columns using ints row-wise."""
    return [ints[i * c : (i + 1) * c] for i in range(r)]


class Make2DArrayTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(make_2d_array(2, 2, [1, 2, 3, 4]), [[1, 2], [3, 4]])
        self.assertEqual(make_2d_array(1, 3, [1, 2, 3]), [[1, 2, 3]])
        self.assertEqual(make_2d_array(4, 1, [1, 2, 3, 4]), [[1], [2], [3], [4]])


if __name__ == "__main__":
    unittest.main()
