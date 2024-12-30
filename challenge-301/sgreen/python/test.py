#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.largest_number([20, 3]), 320)
        self.assertEqual(ch_1.largest_number([3, 30, 34, 5, 9]), 9534330)

    def test_ch_2(self):
        self.assertEqual(ch_2.hamming_distance([4, 14, 2]), 6)
        self.assertEqual(ch_2.hamming_distance([4, 14, 4]), 4)


if __name__ == '__main__':
    unittest.main()
