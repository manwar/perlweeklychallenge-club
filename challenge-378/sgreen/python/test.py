#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.second_largest_digit("aaaaa77777"), -1)
        self.assertEqual(ch_1.second_largest_digit("abcde"), -1)
        self.assertEqual(ch_1.second_largest_digit("9zero8eight7seven9"), 8)
        self.assertEqual(ch_1.second_largest_digit("xyz9876543210"), 8)
        self.assertEqual(ch_1.second_largest_digit("4abc4def2ghi8jkl2"), 4)

    def test_ch_2(self):
        self.assertTrue(ch_2.sum_of_words("acb", "cba", "cdb"))
        self.assertTrue(ch_2.sum_of_words("aab", "aac", "ad"))
        self.assertFalse(ch_2.sum_of_words("bc", "je", "jg"))
        self.assertTrue(ch_2.sum_of_words("a", "aaaa", "aa"))
        self.assertFalse(ch_2.sum_of_words("c", "d", "h"))
        self.assertTrue(ch_2.sum_of_words("gfi", "hbf", "bdhd"))


if __name__ == "__main__":
    unittest.main()
