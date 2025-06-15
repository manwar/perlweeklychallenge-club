#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.consecutive_ones([0, 1, 1, 0, 1, 1, 1]), 3)
        self.assertEqual(ch_1.consecutive_ones([0, 0, 0, 0]), 0)
        self.assertEqual(ch_1.consecutive_ones([1, 0, 1, 0, 1, 1]), 2)

    def test_ch_2(self):
        self.assertEqual(ch_2.final_price([8, 4, 6, 2, 3]), [4, 2, 4, 2, 3])
        self.assertEqual(ch_2.final_price([1, 2, 3, 4, 5]), [1, 2, 3, 4, 5])
        self.assertEqual(ch_2.final_price([7, 1, 1, 5]), [6, 0, 1, 5])


if __name__ == '__main__':
    unittest.main()
