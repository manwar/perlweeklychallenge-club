#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.reverse_existence("abcba"))
        self.assertTrue(ch_1.reverse_existence("racecar"))
        self.assertFalse(ch_1.reverse_existence("abcd"))
        self.assertTrue(ch_1.reverse_existence("banana"))
        self.assertTrue(ch_1.reverse_existence("hello"))

    def test_ch_2(self):
        self.assertEqual(ch_2.prefix_suffix(["a", "aba", "ababa", "aa"]), 4)
        self.assertEqual(ch_2.prefix_suffix(["pa", "papa", "ma", "mama"]), 2)
        self.assertEqual(ch_2.prefix_suffix(["abao", "ab"]), 0)
        self.assertEqual(ch_2.prefix_suffix(["abab", "abab"]), 1)
        self.assertEqual(ch_2.prefix_suffix(["ab", "abab", "ababab"]), 3)


if __name__ == "__main__":
    unittest.main()
