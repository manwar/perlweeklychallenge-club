#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def good_pairs(lst):
    count = 0
    for i in range(len(lst)):
        for j in range(i + 1, len(lst)):
            if lst[i] == lst[j]:
                count += 1
    return count


class TestGoodPairs(unittest.TestCase):

    def test_cases(self):
        self.assertEqual(good_pairs([1, 2, 3, 1, 1, 3]), 4, 'Test Case 1')
        self.assertEqual(good_pairs([1, 2, 3]), 0, 'Test Case 2')
        self.assertEqual(good_pairs([1, 1, 1, 1]), 6, 'Test Case 3')


if __name__ == '__main__':
    unittest.main()
