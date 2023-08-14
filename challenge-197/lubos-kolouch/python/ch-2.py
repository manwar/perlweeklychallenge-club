#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def wiggle_sort(lst):
    for i in range(len(lst) - 1):
        if (i % 2 == 0 and lst[i] > lst[i + 1]) or (i % 2 == 1 and lst[i] < lst[i + 1]):
            lst[i], lst[i + 1] = lst[i + 1], lst[i]
    return lst


class TestWiggleSort(unittest.TestCase):
    def test_cases(self):
        self.assertEqual(wiggle_sort([1, 5, 1, 1, 6, 4]), [1, 5, 1, 6, 1, 4])
        self.assertEqual(wiggle_sort([1, 3, 2, 2, 3, 1]), [1, 3, 2, 3, 1, 2])


if __name__ == '__main__':
    unittest.main()
