#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.broken_keyboard("Hello World", ["d"]), 1)
        self.assertEqual(ch_1.broken_keyboard("apple banana cherry", ["a", "e"]), 0)
        self.assertEqual(ch_1.broken_keyboard("Coding is fun", []), 3)
        self.assertEqual(ch_1.broken_keyboard("The Weekly Challenge", ["a","b"]), 2)
        self.assertEqual(ch_1.broken_keyboard("Perl and Python", ["p"]), 1)

    def test_ch_2(self):
        self.assertEqual(ch_2.reverse_prefix("programming", "g"), "gorpramming")
        self.assertEqual(ch_2.reverse_prefix("hello", "h"), "hello")
        self.assertEqual(ch_2.reverse_prefix("abcdefghij", "h"), "hgfedcbaij")
        self.assertEqual(ch_2.reverse_prefix("reverse", "s"), "srevere")
        self.assertEqual(ch_2.reverse_prefix("perl", "r"), "repl")


if __name__ == "__main__":
    unittest.main()
