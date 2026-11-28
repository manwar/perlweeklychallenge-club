#!/usr/bin/env python3
"""Floor Sum - Perl Weekly Challenge 243, Task 2."""

from __future__ import annotations

import unittest


def floor_sum(nums: list[int]) -> int:
    """Return the sum of floor(nums[i] / nums[j]) for all pairs (i, j)."""
    return sum(a // b for a in nums for b in nums)


class TestFloorSum(unittest.TestCase):
    """Unit tests for the floor_sum function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[list[int], int]] = [
            ([2, 5, 9], 10),
            ([7, 7, 7, 7, 7, 7, 7], 49),
        ]
        for nums, expected in cases:
            with self.subTest(nums=nums):
                self.assertEqual(floor_sum(nums), expected)


if __name__ == "__main__":
    unittest.main()
