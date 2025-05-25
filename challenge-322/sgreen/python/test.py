#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.string_format("ABC-D-E-F", 3), "ABC-DEF")
        self.assertEqual(ch_1.string_format("A-BC-D-E", 2), "A-BC-DE")
        self.assertEqual(ch_1.string_format("A-B-CD-E", 4), "A-BCDE")
        self.assertEqual(ch_1.string_format("AB-C-D-EF", 2), "AB-CD-EF")

    def test_ch_2(self):
        self.assertEqual(ch_2.rank_array([55, 22, 44, 33]), [4, 1, 3, 2])
        self.assertEqual(ch_2.rank_array([10, 10, 10]), [1, 1, 1])
        self.assertEqual(ch_2.rank_array([5, 1, 1, 4, 3]), [4, 1, 1, 3, 2])


if __name__ == "__main__":
    unittest.main()
