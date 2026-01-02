#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.min_abs_diff([4, 2, 1, 3]), [[1, 2], [2, 3], [3, 4]])
        self.assertEqual(ch_1.min_abs_diff([10, 100, 20, 30]), [[10, 20], [20, 30]])
        self.assertEqual(ch_1.min_abs_diff([-5, -2, 0, 3]), [[-2, 0]])
        self.assertEqual(ch_1.min_abs_diff([8, 1, 15, 3]), [[1, 3]])
        self.assertEqual(ch_1.min_abs_diff([12, 5, 9, 1, 15]), [[9, 12], [12, 15]])

    def test_ch_2(self):
        self.assertEqual(ch_2.shift_grid([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1), [[9, 1, 2], [3, 4, 5], [6, 7, 8]])
        self.assertEqual(ch_2.shift_grid([[10, 20],[30, 40]], 1), [[40, 10], [20, 30]])
        self.assertEqual(ch_2.shift_grid([[1, 2], [3, 4], [5, 6]], 1), [[6, 1], [2, 3], [4, 5]])
        self.assertEqual(ch_2.shift_grid([[1, 2, 3], [4, 5, 6],], 5), [[2, 3, 4], [5, 6, 1]])
        self.assertEqual(ch_2.shift_grid([[1, 2, 3, 4]], 1), [[4, 1, 2, 3]])


if __name__ == "__main__":
    unittest.main()
