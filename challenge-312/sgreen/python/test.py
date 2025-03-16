#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.minimum_time('abc'), 5)
        self.assertEqual(ch_1.minimum_time('bza'), 7)
        self.assertEqual(ch_1.minimum_time('zjpc'), 34)

    def test_ch_2(self):
        self.assertEqual(ch_2.ball_and_boxes('G0B1R2R0B0'), 1)
        self.assertEqual(ch_2.ball_and_boxes('G1R3R6B3G6B1B6R1G3'), 3)
        self.assertEqual(ch_2.ball_and_boxes('B3B2G1B3'), 0)


if __name__ == '__main__':
    unittest.main()
