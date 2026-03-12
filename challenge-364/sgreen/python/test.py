#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.decrypt_string("10#11#12"), "jkab")
        self.assertEqual(ch_1.decrypt_string("1326#"), "acz")
        self.assertEqual(ch_1.decrypt_string("25#24#123"), "yxabc")
        self.assertEqual(ch_1.decrypt_string("20#5"), "te")
        self.assertEqual(ch_1.decrypt_string("1910#26#"), "aijz")

    def test_ch_2(self):
        self.assertEqual(ch_2.good_parser("G()(al)"), "Goal")
        self.assertEqual(ch_2.good_parser("G()()()()(al)"), "Gooooal")
        self.assertEqual(ch_2.good_parser("(al)G(al)()()"), "alGaloo")
        self.assertEqual(ch_2.good_parser("()G()G"), "oGoG")
        self.assertEqual(ch_2.good_parser("(al)(al)G()()"), "alalGoo")


if __name__ == "__main__":
    unittest.main()
