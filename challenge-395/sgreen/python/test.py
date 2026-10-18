#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.complex_number("1+1i", "1+1i"), "0+2i")
        self.assertEqual(ch_1.complex_number("1+(-1)i", "1+(-1)i"), "0+(-2)i")
        self.assertEqual(ch_1.complex_number("0+3i", "0+4i"), "-12+0i")
        self.assertEqual(ch_1.complex_number("3+4i", "3+(-4)i"), "25+0i")
        self.assertEqual(ch_1.complex_number("50+(-20)i", "-10+30i"), "100+1700i")

    def test_ch_2(self):
        words_list = [
            ["MA", "AM", "MY", "ME"],
            ["SUN", "USE", "NET", "SEE", "TEN"],
            ["BOAT", "TEAL", "AREA", "TSAR", "OGRE"],
            ["CARD", "AREA", "REAR", "DART"],
            ["HEART", "TREND", "EMBER", "RESIN", "ABUSE"],
        ]

        expected_results = [
            ["MA", "AM"],
            ["SUN", "USE", "NET"],
            ["BOAT", "OGRE", "AREA", "TEAL"],
            ["CARD", "AREA", "REAR", "DART"],
            ["HEART", "EMBER", "ABUSE", "RESIN", "TREND"],
        ]

        for words, expected_result in zip(words_list, expected_results):
            self.assertEqual(ch_2.word_squares(words), expected_result)


if __name__ == "__main__":
    unittest.main()
