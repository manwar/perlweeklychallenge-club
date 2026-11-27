#!/usr/bin/env python3
"""Group Hero - Perl Weekly Challenge 244, Task 2."""

from __future__ import annotations

from itertools import combinations
import unittest


def group_hero_power(nums: list[int]) -> int:
    """Return the sum of powers of all non-empty combinations of nums."""
    total_power = 0
    for i in range(1, len(nums) + 1):
        for combo in combinations(nums, i):
            total_power += max(combo) ** 2 * min(combo)
    return total_power


class TestGroupHeroPower(unittest.TestCase):
    """Unit tests for the group_hero_power function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[list[int], int]] = [
            ([2, 1, 4], 141),
        ]
        for nums, expected in cases:
            with self.subTest(nums=nums):
                self.assertEqual(group_hero_power(nums), expected)


if __name__ == "__main__":
    unittest.main()
