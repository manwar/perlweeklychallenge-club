#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.sum_of_frequencies("banana"), 5)
        self.assertEqual(ch_1.sum_of_frequencies("teestett"), 7)
        self.assertEqual(ch_1.sum_of_frequencies("aeiouuaa"), 3)
        self.assertEqual(ch_1.sum_of_frequencies("rhythm"), 2)
        self.assertEqual(ch_1.sum_of_frequencies("x"), 1)

    def test_ch_2(self):
        self.assertEqual(ch_2.reverse_degree("z"), 1)
        self.assertEqual(ch_2.reverse_degree("a"), 26)
        self.assertEqual(ch_2.reverse_degree("bbc"), 147)
        self.assertEqual(ch_2.reverse_degree("racecar"), 560)
        self.assertEqual(ch_2.reverse_degree("zyx"), 14)


if __name__ == "__main__":
    unittest.main()
