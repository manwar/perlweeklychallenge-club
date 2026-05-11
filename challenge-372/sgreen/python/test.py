#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.rearrange_space("  challenge  "), "challenge    ")
        self.assertEqual(ch_1.rearrange_space("coding  is  fun"), "coding  is  fun")
        self.assertEqual(ch_1.rearrange_space("a b c  d"), "a b c d ")
        self.assertEqual(ch_1.rearrange_space("  team      pwc  "), "team          pwc")
        self.assertEqual(ch_1.rearrange_space("   the  weekly  challenge  "), "the    weekly    challenge ")

    def test_ch_2(self):
        self.assertEqual(ch_2.largest_substring("aaaaa"), 3)
        self.assertEqual(ch_2.largest_substring("abcdeba"), 5)
        self.assertEqual(ch_2.largest_substring("abbc"), 0)
        self.assertEqual(ch_2.largest_substring("abcaacbc"), 4)
        self.assertEqual(ch_2.largest_substring("laptop"), 2)
        self.assertEqual(ch_2.largest_substring("abc"), -1)


if __name__ == "__main__":
    unittest.main()
