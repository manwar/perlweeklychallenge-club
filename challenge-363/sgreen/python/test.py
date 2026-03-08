#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        string_1 = "aa — two vowels and zero consonants"
        string_2 = "iv — one vowel and one consonant"
        string_3 = "hello - three vowels and two consonants"
        string_4 = "aeiou — five vowels and zero consonants"
        string_5 = "aei — three vowels and zero consonants"

        self.assertTrue(ch_1.string_lie_detector(string_1))
        self.assertTrue(ch_1.string_lie_detector(string_2))
        self.assertFalse(ch_1.string_lie_detector(string_3))
        self.assertTrue(ch_1.string_lie_detector(string_4))
        self.assertTrue(ch_1.string_lie_detector(string_5))

    def test_ch_2(self):
        self.assertTrue(ch_2.subnet_sheriff("192.168.1.45", "192.168.1.0/24"))
        self.assertFalse(ch_2.subnet_sheriff("10.0.0.256", "10.0.0.0/24"))
        self.assertTrue(ch_2.subnet_sheriff("172.16.8.9", "172.16.8.9/32"))
        self.assertTrue(ch_2.subnet_sheriff("172.16.4.5", "172.16.0.0/14"))
        self.assertTrue(ch_2.subnet_sheriff("192.0.2.0", "192.0.2.0/25"))
        self.assertFalse(ch_2.subnet_sheriff("1.1.1.1", "10.0.0.0/8"))


if __name__ == "__main__":
    unittest.main()
