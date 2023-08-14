#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def max_gap(lst):
    if len(lst) < 2:
        return 0
    lst.sort()
    max_gap = max(lst[i + 1] - lst[i] for i in range(len(lst) - 1))
    return sum(1 for i in range(len(lst) - 1)
               if lst[i + 1] - lst[i] == max_gap)


class TestMaxGap(unittest.TestCase):

    def test_cases(self):
        self.assertEqual(max_gap([2, 5, 8, 1]), 2, 'Test Case 1')
        self.assertEqual(max_gap([3]), 0, 'Test Case 2')


if __name__ == '__main__':
    unittest.main()
