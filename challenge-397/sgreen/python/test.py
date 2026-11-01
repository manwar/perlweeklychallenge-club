#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.asp([1, 2, 4, 5, 6]), 7)
        self.assertEqual(ch_1.asp([-5, -2, -1, 3]), 1)
        self.assertEqual(ch_1.asp([1, 2, 3]), 4)
        self.assertEqual(ch_1.asp([2, 3, 7, 8]), 6)
        self.assertEqual(ch_1.asp([1, 1, 1, 10]), 4)

    def test_ch_2(self):
        self.assertEqual(ch_2.binary_reflection([3, 6, 12]), [3, 6, 12])
        self.assertEqual(ch_2.binary_reflection([1, 2, 4, 8]), [1, 2, 4, 8])
        self.assertEqual(ch_2.binary_reflection([7, 8, 9, 10]), [8, 10, 7, 9])
        self.assertEqual(ch_2.binary_reflection([5, 9, 15, 17]), [5, 9, 15, 17])
        self.assertEqual(ch_2.binary_reflection([11, 13, 14, 19]), [14, 13, 11, 19])


if __name__ == "__main__":
    unittest.main()
