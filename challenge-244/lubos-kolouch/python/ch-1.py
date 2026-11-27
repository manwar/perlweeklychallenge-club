#!/usr/bin/env python3
"""Count Smaller - Perl Weekly Challenge 244, Task 1."""

from __future__ import annotations

import unittest


def count_smaller(nums: list[int]) -> list[int]:
    """Count the number of elements smaller than the element at each index."""
    n = len(nums)
    result: list[int] = []
    for i in range(n):
        count = sum(1 for j in range(n) if nums[j] < nums[i] and j != i)
        result.append(count)
    return result


class TestCountSmaller(unittest.TestCase):
    """Unit tests for the count_smaller function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[list[int], list[int]]] = [
            ([8, 1, 2, 2, 3], [4, 0, 1, 1, 3]),
            ([6, 5, 4, 8], [2, 1, 0, 3]),
            ([2, 2, 2], [0, 0, 0]),
        ]
        for nums, expected in cases:
            with self.subTest(nums=nums):
                self.assertEqual(count_smaller(nums), expected)


if __name__ == "__main__":
    unittest.main()
