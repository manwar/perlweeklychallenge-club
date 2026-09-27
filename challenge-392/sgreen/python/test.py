#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.convert_palindrome("pinnipeds"), "sdepinnipeds")
        self.assertEqual(ch_1.convert_palindrome("abcd"), "dcbabcd")
        self.assertEqual(ch_1.convert_palindrome("bananas"), "sananabananas")
        self.assertEqual(ch_1.convert_palindrome("dissident"), "tnedissident")
        self.assertEqual(ch_1.convert_palindrome("cailliachs"), "shcailliachs")

    def test_ch_2(self):
        self.assertEqual(ch_2.word_length_product(["a", "ab", "abc", "d", "de", "def"]), 9)
        self.assertEqual(ch_2.word_length_product(["a", "aa", "aaa", "aaaa"]), 0)
        self.assertEqual(ch_2.word_length_product(["meet", "app", "code", "sky", "bold"]), 16)
        self.assertEqual(ch_2.word_length_product(["a", "ab", "abc", "abcd", "efghi"]), 20)
        self.assertEqual(ch_2.word_length_product(["xyz", "w", "abcdefg", "hij"]), 21)


if __name__ == "__main__":
    unittest.main()
