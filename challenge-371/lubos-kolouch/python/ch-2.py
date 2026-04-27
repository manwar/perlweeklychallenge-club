#!/usr/bin/env python3
"""
Task: Subset Equilibrium (Weekly Challenge 371)

Find all subsets of an array where the sum of elements equals the sum of their 1-based indices.
"""

from __future__ import annotations

import unittest


def find_equilibrium_subsets(ints: list[int]) -> list[list[int]]:
    """Return all equilibrium subsets from the given array."""
    n = len(ints)
    results = []

    # Iterate through all non-empty subsets using bitmask
    for mask in range(1, 1 << n):
        sum_vals = 0
        sum_inds = 0
        subset = []

        for i in range(n):
            if mask & (1 << i):
                sum_vals += ints[i]
                sum_inds += i + 1
                subset.append(ints[i])

        if sum_vals == sum_inds:
            results.append(subset)

    return results


class TestSubsetEquilibrium(unittest.TestCase):
    def test_example_1(self):
        # Subset lists are compared. The exact order within 'results' depends on bitmask order.
        # Mask 0011 (binary) corresponds to first two elements (2, 1). Sum vals=3, sum inds=1+2=3.
        # Mask 1100 corresponds to last two elements (4, 3). Sum vals=7, sum inds=3+4=7.
        # Mask 1111 corresponds to all elements. Sum vals=10, sum inds=10.
        expected = [[2, 1], [4, 3], [2, 1, 4, 3]]
        self.assertEqual(find_equilibrium_subsets([2, 1, 4, 3]), expected)

    def test_custom_1(self):
        # Array [1, 2, 3] -> indices 1, 2, 3.
        # Any combination of elements i from indices i will work.
        # So all non-empty subsets are equilibrium subsets.
        # (1), (2), (3), (1, 2), (1, 3), (2, 3), (1, 2, 3)
        res = find_equilibrium_subsets([1, 2, 3])
        self.assertEqual(len(res), 7)


if __name__ == "__main__":
    unittest.main()
