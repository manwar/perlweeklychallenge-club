#!/usr/bin/env python3
"""
Task: Final Price (Weekly Challenge 325)

For each price, subtract the first subsequent price that is <= it; if none, keep the original price.
"""
from __future__ import annotations

from typing import List
import unittest


def final_price(prices: List[int]) -> List[int]:
    result: List[int] = []
    n = len(prices)
    for i, price in enumerate(prices):
        discount = 0
        for j in range(i + 1, n):
            if prices[j] <= price:
                discount = prices[j]
                break
        result.append(price - discount)
    return result


class FinalPriceTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(final_price([8, 4, 6, 2, 3]), [4, 2, 4, 2, 3])
        self.assertEqual(final_price([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5])
        self.assertEqual(final_price([7, 1, 1, 5]), [6, 0, 1, 5])


if __name__ == "__main__":
    unittest.main()
