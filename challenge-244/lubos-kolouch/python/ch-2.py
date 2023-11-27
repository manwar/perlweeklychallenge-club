#!/usr/bin/env python

import unittest
from itertools import combinations
from typing import List


def group_hero_power(nums: list[int]) -> int:
    total_power = 0
    for i in range(1, len(nums) + 1):
        for combo in combinations(nums, i):
            total_power += max(combo) ** 2 * min(combo)
    return total_power


# Tests
class TestGroupHeroPower(unittest.TestCase):
    def test_example(self):
        self.assertEqual(group_hero_power([2, 1, 4]), 141)


if __name__ == "__main__":
    unittest.main()
