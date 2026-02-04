#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.get_digital_root(38), (2, 2))
        self.assertEqual(ch_1.get_digital_root(7), (0, 7))
        self.assertEqual(ch_1.get_digital_root(999), (2, 9))
        self.assertEqual(ch_1.get_digital_root(1999999999), (3, 1))
        self.assertEqual(ch_1.get_digital_root(101010), (1, 3))

    def test_ch_2(self):
        self.assertEqual(ch_2.string_reduction("aabbccdd"), "")
        self.assertEqual(ch_2.string_reduction("abccba"), "")
        self.assertEqual(ch_2.string_reduction("abcdef"), "abcdef")
        self.assertEqual(ch_2.string_reduction("aabbaeaccdd"), "aea")
        self.assertEqual(ch_2.string_reduction("mississippi"), "m")


if __name__ == "__main__":
    unittest.main()
