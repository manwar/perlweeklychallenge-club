#!/usr/bin/env python3
"""
The Weekly Challenge 339 Task 1: Max Diff

Given a list of at least four integers, find two disjoint pairs whose product
absolute difference is maximal. For every combination of four numbers the
script evaluates the three distinct pairings, computes the absolute difference
of their products, and keeps the largest value encountered.
"""
from itertools import combinations
import unittest

IntList = list[int]
PAIRINGS = (
    ((0, 1), (2, 3)),
    ((0, 2), (1, 3)),
    ((0, 3), (1, 2)),
)


def max_product_difference(ints: IntList) -> int:
    """Return the maximum product difference obtainable from two disjoint pairs."""
    if len(ints) < 4:
        msg = "Need at least four integers"
        raise ValueError(msg)

    best = 0
    for indices in combinations(range(len(ints)), 4):
        values = [ints[i] for i in indices]
        for first, second in PAIRINGS:
            prod1 = values[first[0]] * values[first[1]]
            prod2 = values[second[0]] * values[second[1]]
            diff = abs(prod1 - prod2)
            if diff > best:
                best = diff
    return best


class TestMaxProductDifference(unittest.TestCase):
    """Unit tests covering the provided examples."""

    def test_example1(self) -> None:
        ints = [5, 9, 3, 4, 6]
        self.assertEqual(max_product_difference(ints), 42)

    def test_example2(self) -> None:
        ints = [1, -2, 3, -4]
        self.assertEqual(max_product_difference(ints), 10)

    def test_example3(self) -> None:
        ints = [-3, -1, -2, -4]
        self.assertEqual(max_product_difference(ints), 10)

    def test_example4(self) -> None:
        ints = [10, 2, 0, 5, 1]
        self.assertEqual(max_product_difference(ints), 50)

    def test_example5(self) -> None:
        ints = [7, 8, 9, 10, 10]
        self.assertEqual(max_product_difference(ints), 44)


if __name__ == "__main__":
    unittest.main()
