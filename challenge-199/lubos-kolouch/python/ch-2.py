#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def good_triplets(x, y, z, lst):
    count = 0
    for i in range(len(lst) - 2):
        for j in range(i + 1, len(lst) - 1):
            for k in range(j + 1, len(lst)):
                if abs(lst[i] - lst[j]) <= x and \
                   abs(lst[j] - lst[k]) <= y and \
                   abs(lst[i] - lst[k]) <= z:
                    count += 1
    return count


class TestGoodTriplets(unittest.TestCase):

    def test_cases(self):
        self.assertEqual(good_triplets(7, 2, 3, [3, 0, 1, 1, 9, 7]), 4,
                         'Test Case 1')
        self.assertEqual(good_triplets(0, 0, 1, [1, 1, 2, 2, 3]), 0,
                         'Test Case 2')


if __name__ == '__main__':
    unittest.main()
