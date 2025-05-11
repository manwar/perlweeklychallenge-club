#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.maximum_count([-3, -2, -1, 1, 2, 3]), 3)
        self.assertEqual(ch_1.maximum_count([-2, -1, 0, 0, 1]), 2)
        self.assertEqual(ch_1.maximum_count([1, 2, 3, 4]), 4)

    def test_ch_2(self):
        self.assertEqual(ch_2.sum_difference([1, 23, 4, 5]), 18)
        self.assertEqual(ch_2.sum_difference([1, 2, 3, 4, 5]), 0)
        self.assertEqual(ch_2.sum_difference([1, 2, 34]), 27)


if __name__ == '__main__':
    unittest.main()
