#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.missing_integers([1, 2, 1, 3, 2, 5]), [4, 6])
        self.assertEqual(ch_1.missing_integers([1, 1, 1]), [2, 3])
        self.assertEqual(ch_1.missing_integers([2, 2, 1]), [3])

    def test_ch_2(self):
        self.assertEqual(ch_2.mad([4, 1, 2, 3]), [[1,2], [2,3], [3,4]])
        self.assertEqual(ch_2.mad([1, 3, 7, 11, 15]), [[1,3]])
        self.assertEqual(ch_2.mad([1, 5, 3, 8]), [[1,3], [3,5]])


if __name__ == '__main__':
    unittest.main()
