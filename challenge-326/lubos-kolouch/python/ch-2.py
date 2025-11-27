#!/usr/bin/env python3
"""
Task: Decompressed List (Weekly Challenge 326)

Given pairs (count, value), build the decompressed list.
"""
from __future__ import annotations

from typing import List
import unittest


def decompress_list(ints: List[int]) -> List[int]:
    """Decompress adjacent pairs (count, value)."""
    out: List[int] = []
    for i in range(0, len(ints), 2):
        count, value = ints[i], ints[i + 1]
        out.extend([value] * count)
    return out


class DecompressListTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(decompress_list([1, 3, 2, 4]), [3, 4, 4])
        self.assertEqual(decompress_list([1, 1, 2, 2]), [1, 2, 2])
        self.assertEqual(decompress_list([3, 1, 3, 2]), [1, 1, 1, 2, 2, 2])


if __name__ == "__main__":
    unittest.main()
