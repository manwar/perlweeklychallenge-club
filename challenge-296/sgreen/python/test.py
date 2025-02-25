#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.string_compress('abbc'), 'a2bc')
        self.assertEqual(ch_1.string_compress('aaabccc'), '3ab3c')
        self.assertEqual(ch_1.string_compress('abcc'), 'ab2c')

        self.assertEqual(ch_1.string_decompress('a2bc'), 'abbc')
        self.assertEqual(ch_1.string_decompress('3ab3c'), 'aaabccc')
        self.assertEqual(ch_1.string_decompress('ab2c'), 'abcc')

    def test_ch_2(self):
        self.assertTrue(ch_2.matchstick_square([1, 2, 2, 2, 1]))
        self.assertFalse(ch_2.matchstick_square([2, 2, 2, 4]))
        self.assertFalse(ch_2.matchstick_square([2, 2, 2, 2, 4]))
        self.assertTrue(ch_2.matchstick_square([3, 4, 1, 4, 3, 1]))


if __name__ == '__main__':
    unittest.main()
