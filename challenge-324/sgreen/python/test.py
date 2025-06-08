#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.twod_array([1, 2, 3, 4], 2, 2), [[1, 2], [3, 4]])
        self.assertEqual(ch_1.twod_array([1, 2, 3], 1, 3), [[1, 2, 3]])
        self.assertEqual(ch_1.twod_array([1, 2, 3, 4], 4, 1), [[1], [2], [3], [4]])

    def test_ch_2(self):
        self.assertEqual(ch_2.total_xor([1, 3]), 6)
        self.assertEqual(ch_2.total_xor([5, 1, 6]), 28)
        self.assertEqual(ch_2.total_xor([3, 4, 5, 6, 7, 8]), 480)


if __name__ == '__main__':
    unittest.main()
