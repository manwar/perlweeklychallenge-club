#!/usr/bin/env python3
"""
Task: Tax Amount (Weekly Challenge 323)

Compute progressive tax for given income and brackets [upper, percent].
"""
from __future__ import annotations

from typing import List, Tuple
import unittest


def tax_amount(income: int, brackets: List[Tuple[int, int]]) -> float:
    total = 0.0
    prev = 0
    for upper, percent in brackets:
        if income <= prev:
            break
        taxable = min(income, upper) - prev
        total += taxable * (percent / 100)
        prev = upper
    return total


class TaxAmountTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertAlmostEqual(tax_amount(10, [(3, 50), (7, 10), (12, 25)]), 2.65, places=2)
        self.assertAlmostEqual(tax_amount(2, [(1, 0), (4, 25), (5, 50)]), 0.25, places=2)
        self.assertAlmostEqual(tax_amount(0, [(2, 50)]), 0.0, places=2)


if __name__ == "__main__":
    unittest.main()
