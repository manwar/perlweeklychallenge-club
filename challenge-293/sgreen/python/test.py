#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.similar_dominoes([[1, 3], [3, 1], [2, 4], [6, 8]]), 2)
        self.assertEqual(ch_1.similar_dominoes([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]), 3)

    def test_ch_2(self):
        self.assertTrue(ch_2.is_boomerang([[1, 1], [2, 3], [3,2]]))
        self.assertFalse(ch_2.is_boomerang([[1, 1], [2, 2], [3, 3]]))
        self.assertTrue(ch_2.is_boomerang([[1, 1], [1, 2], [2, 3]]))
        self.assertFalse(ch_2.is_boomerang([[1, 1], [1, 2], [1, 3]]))
        self.assertFalse(ch_2.is_boomerang([[1, 1], [2, 1], [3, 1]]))
        self.assertTrue(ch_2.is_boomerang([[0, 0], [2, 3], [4, 5]]))


if __name__ == '__main__':
    unittest.main()
