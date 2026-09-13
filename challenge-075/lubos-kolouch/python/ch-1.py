#!/usr/bin/env python3
"""Perl Weekly Challenge 075 - Task 1: Coins Sum.

Find how many ways to make target sum S using coins from set C (unlimited amount of each).
"""

from __future__ import annotations

import unittest


def count_coin_ways(coins: list[int], target_sum: int) -> int:
    """Calculate the number of combinations of coins that sum to target_sum.

    :param coins: List of available coin denominations.
    :param target_sum: Target sum to achieve.
    :return: Number of distinct coin combinations.
    """
    if target_sum == 0:
        return 1
    if target_sum < 0 or not coins:
        return 0

    ways = [0] * (target_sum + 1)
    ways[0] = 1

    for coin in coins:
        if coin <= 0:
            continue
        for j in range(coin, target_sum + 1):
            ways[j] += ways[j - coin]

    return ways[target_sum]


class TestCoinsSum(unittest.TestCase):
    """Test cases for count_coin_ways."""

    def test_example_1(self) -> None:
        self.assertEqual(count_coin_ways([1, 2, 4], 6), 6)

    def test_example_2(self) -> None:
        self.assertEqual(count_coin_ways([1, 5, 10], 12), 4)

    def test_impossible(self) -> None:
        self.assertEqual(count_coin_ways([2], 3), 0)

    def test_zero_sum(self) -> None:
        self.assertEqual(count_coin_ways([1, 2], 0), 1)


if __name__ == "__main__":
    unittest.main()
