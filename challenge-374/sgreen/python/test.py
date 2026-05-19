#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.count_vowel("aeiou"), ["aeiou"])
        self.assertEqual(
            ch_1.count_vowel("aaeeeiioouu"),
            ["aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu"]
        )
        self.assertEqual(
            ch_1.count_vowel("aeiouuaxaeiou"),
            ["aeiou", "aeiouu", "aeiouua", "eiouua", "aeiou"]
        )
        self.assertEqual(ch_1.count_vowel("uaeiou"), ["uaeio", "uaeiou", "aeiou"])
        self.assertEqual(ch_1.count_vowel("aeioaeioa"), [])

    def test_ch_2(self):
        self.assertEqual(ch_2.largest_number("6777133339"), 3333)
        self.assertEqual(ch_2.largest_number("1200034"), 4)
        self.assertEqual(ch_2.largest_number("44221155"), 55)
        self.assertEqual(ch_2.largest_number("88888"), 88888)
        self.assertEqual(ch_2.largest_number("11122233"), 222)
        self.assertEqual(ch_2.largest_number("11212233"), 222)


if __name__ == "__main__":
    unittest.main()
