#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def find_missing_numbers(arr):
    n = len(arr)
    s = set(arr)
    missing_numbers = []
    for i in range(n + 1):
        if i not in s:
            missing_numbers.append(i)
    return missing_numbers


# test cases
class TestMissingNumbers(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(find_missing_numbers([0, 1, 3]), [2])

    def test_example2(self):
        self.assertEqual(find_missing_numbers([0, 1]), [2])


if __name__ == '__main__':
    unittest.main()
