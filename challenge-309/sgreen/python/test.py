#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.min_gap([2, 8, 10, 11, 15]), 11)
        self.assertEqual(ch_1.min_gap([1, 5, 6, 7, 14]), 6)
        self.assertEqual(ch_1.min_gap([8, 20, 25, 28]), 28)

    def test_ch_2(self):
        self.assertEqual(ch_2.min_diff([1, 5, 8, 9]), 1)
        self.assertEqual(ch_2.min_diff([9, 4, 1, 7]), 2)


if __name__ == '__main__':
    unittest.main()
