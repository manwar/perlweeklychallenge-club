#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
from collections import Counter
from typing import List


def get_maximum_points(integers: List[int]) -> int:
    freq = Counter(integers)
    max_points = 0

    # Sort and iterate through unique integers
    for num in sorted(set(integers)):
        points = freq[num] * num
        points += freq[num - 1] * (num - 1) if (num - 1) in freq else 0
        points += freq[num + 1] * (num + 1) if (num + 1) in freq else 0
        max_points = max(max_points, points)

    return max_points


class TestGetMaximumPoints(unittest.TestCase):

    def test_case_1(self):
        self.assertEqual(get_maximum_points([2, 3, 1]), 6)

    def test_case_2(self):
        self.assertEqual(get_maximum_points([1, 1, 2, 2, 2, 3]), 11)


if __name__ == "__main__":
    unittest.main()
