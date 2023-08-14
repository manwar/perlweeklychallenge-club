#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def arithmetic_slices(lst):
    if len(lst) < 3:
        return []

    slices = []
    for i in range(len(lst) - 2):
        if lst[i + 1] - lst[i] == lst[i + 2] - lst[i + 1]:
            diff = lst[i + 1] - lst[i]
            slice = [lst[i], lst[i + 1], lst[i + 2]]
            slices.append(slice[:])
            for j in range(i + 3, len(lst)):
                if lst[j] - lst[j - 1] == diff:
                    slice.append(lst[j])
                    slices.append(slice[:])
                else:
                    break

    return slices


class TestArithmeticSlices(unittest.TestCase):

    def test_cases(self):
        self.assertEqual(arithmetic_slices([1, 2, 3, 4]),
                         [[1, 2, 3], [1, 2, 3, 4], [2, 3, 4]], 'Test Case 1')
        self.assertEqual(arithmetic_slices([2]), [], 'Test Case 2')


if __name__ == '__main__':
    unittest.main()
