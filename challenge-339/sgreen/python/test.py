#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.max_diff([5, 9, 3, 4, 6]), 42)
        self.assertEqual(ch_1.max_diff([1, -2, 3, -4]), 10)
        self.assertEqual(ch_1.max_diff([-3, -1, -2, -4]), 10)
        self.assertEqual(ch_1.max_diff([10, 2, 0, 5, 1]), 50)
        self.assertEqual(ch_1.max_diff([7, 8, 9, 10, 10]), 44)

    def test_ch_2(self):
        self.assertEqual(ch_2.peak_point([-5, 1, 5, -9, 2]), 1)
        self.assertEqual(ch_2.peak_point([10, 10, 10, -25]), 30)
        self.assertEqual(ch_2.peak_point([3, -4, 2, 5, -6, 1]), 6)
        self.assertEqual(ch_2.peak_point([-1, -2, -3, -4]), 0)
        self.assertEqual(ch_2.peak_point([-10, 15, 5]), 10)


if __name__ == '__main__':
    unittest.main()
