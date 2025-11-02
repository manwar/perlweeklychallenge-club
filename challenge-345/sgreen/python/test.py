#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.peak_positions([1, 3, 2]), [1])
        self.assertEqual(ch_1.peak_positions([2, 4, 6, 5, 3]), [2])
        self.assertEqual(ch_1.peak_positions([1, 2, 3, 2, 4, 1]), [2, 4])
        self.assertEqual(ch_1.peak_positions([5, 3, 1]), [0])
        self.assertEqual(ch_1.peak_positions([1, 5, 1, 5, 1, 5, 1]), [1, 3, 5])
        self.assertEqual(ch_1.peak_positions([1, 2, 3, 4, 4]), [])

    def test_ch_2(self):
        self.assertEqual(ch_2.last_visitor([5, -1, -1]), [5, -1])
        self.assertEqual(ch_2.last_visitor([3, 7, -1, -1, -1]), [7, 3, -1])
        self.assertEqual(ch_2.last_visitor([2, -1, 4, -1, -1]), [2, 4, 2])
        self.assertEqual(ch_2.last_visitor([10, 20, -1, 30, -1, -1]), [20, 30, 20])
        self.assertEqual(ch_2.last_visitor([-1, -1, 5, -1]), [-1, -1, 5])


if __name__ == '__main__':
    unittest.main()
