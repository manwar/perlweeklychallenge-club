#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.maximum_ones([[0, 1],[1, 0]]), 1)
        self.assertEqual(ch_1.maximum_ones([[0, 0, 0],[1, 0, 1]]), 2)
        self.assertEqual(ch_1.maximum_ones([[0, 0],[1, 1],[0, 0]]), 2)

    def test_ch_2(self):
        self.assertEqual(
            ch_2.sort_by_1_bits([0, 1, 2, 3, 4, 5, 6, 7, 8]),
            [0, 1, 2, 4, 8, 3, 5, 6, 7]
        )
        self.assertEqual(
            ch_2.sort_by_1_bits([1024, 512, 256, 128, 64]),
            [64, 128, 256, 512, 1024]
        )


if __name__ == '__main__':
    unittest.main()
