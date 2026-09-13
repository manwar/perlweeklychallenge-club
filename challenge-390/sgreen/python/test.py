#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.decode_string("2[3[a]]"), "aaaaaa")
        self.assertEqual(ch_1.decode_string("10[a]"), "aaaaaaaaaa")
        self.assertEqual(ch_1.decode_string("a2[b]c3[d]e"), "abbcddde")
        self.assertEqual(ch_1.decode_string("2[a2[b]c]"), "abbcabbc")
        self.assertEqual(ch_1.decode_string("1[a]2[b3[c]]"), "abcccbccc")

    def test_ch_2(self):
        self.assertEqual(ch_2.order_characters("dbca", 1), "adbc")
        self.assertEqual(ch_2.order_characters("geeks", 2), "eegks")
        self.assertEqual(ch_2.order_characters("cbaed", 3), "abcde")
        self.assertEqual(ch_2.order_characters("fedcba", 4), "abcdef")
        self.assertEqual(ch_2.order_characters("perl", 1), "erlp")
        self.assertEqual(ch_2.order_characters("oloolooo", 1), "looloooo")
        self.assertEqual(ch_2.order_characters("oloooolo", 1), "looloooo")


if __name__ == "__main__":
    unittest.main()
