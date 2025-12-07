#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.good_substr('abcaefg'), 5)
        self.assertEqual(ch_1.good_substr('xyzzabc'), 3)
        self.assertEqual(ch_1.good_substr('aababc'), 1)
        self.assertEqual(ch_1.good_substr('qwerty'), 4)
        self.assertEqual(ch_1.good_substr('zzzaaa'), 0)

    def test_ch_2(self):
        self.assertEqual(ch_2.shuffle_pairs(1, 1000, 1), 0)
        self.assertEqual(ch_2.shuffle_pairs(1500, 2500, 1), 3)
        self.assertEqual(ch_2.shuffle_pairs(1_000_000, 1_500_000, 5), 2)
        self.assertEqual(ch_2.shuffle_pairs(13_427_000, 14_100_000, 2), 11)
        self.assertEqual(ch_2.shuffle_pairs(1030, 1130, 1), 2)


if __name__ == '__main__':
    unittest.main()
