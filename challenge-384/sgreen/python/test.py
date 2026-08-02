#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.base_n(42, 2), "101010")
        self.assertEqual(ch_1.base_n(15642094, 16), "EEADEE")
        self.assertEqual(ch_1.base_n(493, 8), "755")
        self.assertEqual(ch_1.base_n(2228519, 36), "1BRJB")
        self.assertEqual(ch_1.base_n(123456789, 64), "7MyqL")

    def test_ch_2(self):
        self.assertEqual(ch_2.special_binary_substrings("0101"), ["01", "10", "01"])
        self.assertEqual(ch_2.special_binary_substrings("000111"), ["000111", "0011", "01"])
        self.assertEqual(ch_2.special_binary_substrings("000011"), ["0011", "01"])
        self.assertEqual(ch_2.special_binary_substrings("10011100"), ["10", "0011", "01", "1100", "10"])
        self.assertEqual(ch_2.special_binary_substrings("00000"), [])


if __name__ == "__main__":
    unittest.main()
