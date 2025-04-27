#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.group_position("abccccd"), ["cccc"])
        self.assertEqual(ch_1.group_position("aaabcddddeefff"), ["aaa", "dddd", "fff"])
        self.assertEqual(ch_1.group_position("abcdd"), [])

    def test_ch_2(self):
        self.assertTrue(ch_2.reverse_equal([3, 2, 1, 4], [3, 2, 1, 4]))
        self.assertFalse(ch_2.reverse_equal([1, 3, 4], [4, 1, 3]))
        self.assertTrue(ch_2.reverse_equal([2], [2]))


if __name__ == '__main__':
    unittest.main()
