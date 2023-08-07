#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def total_zero(x, y):
    operations = 0

    while x != 0 and y != 0:
        if x > y:
            operations += x // y
            x %= y
        else:
            operations += y // x
            y %= x

    return operations


class TestTotalZero(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(total_zero(5, 4), 5)
        self.assertEqual(total_zero(4, 6), 3)
        self.assertEqual(total_zero(2, 5), 4)
        self.assertEqual(total_zero(3, 1), 3)
        self.assertEqual(total_zero(7, 4), 5)


if __name__ == '__main__':
    unittest.main()
