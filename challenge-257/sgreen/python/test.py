#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.smaller_than_current([5, 2, 1, 6]), [2, 1, 0, 3])
        self.assertEqual(ch_1.smaller_than_current([1, 2, 0, 3]), [1, 2, 0, 3])
        self.assertEqual(ch_1.smaller_than_current([0, 1]), [0, 1])
        self.assertEqual(ch_1.smaller_than_current([9, 4, 9, 2]), [2, 1, 2, 0])

    def test_ch_2(self):
        self.assertEqual(ch_2.echelon(
            [[1, 0, 0, 1], [0, 1, 0, 2], [0, 0, 1, 3]]), 1)
        self.assertEqual(ch_2.echelon([[1, 1, 0], [0, 1, 0], [0, 0, 0]]), 0)
        self.assertEqual(ch_2.echelon(
            [[0, 1, -2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]), 1)
        self.assertEqual(ch_2.echelon(
            [[1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]), 1)


if __name__ == '__main__':
    unittest.main()
