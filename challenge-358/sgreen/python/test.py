#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.max_string_value(["123", "45", "6"]), 123)
        self.assertEqual(ch_1.max_string_value(["abc", "de", "fghi"]), 4)
        self.assertEqual(ch_1.max_string_value(["0012", "99", "a1b2c"]), 99)
        self.assertEqual(ch_1.max_string_value(["x", "10", "xyz", "007"]), 10)
        self.assertEqual(ch_1.max_string_value(["hello123", "2026", "perl"]), 2026)

    def test_ch_2(self):
        self.assertEqual(ch_2.encrypted_string("abc", 1), "bcd")
        self.assertEqual(ch_2.encrypted_string("xyz", 2), "zab")
        self.assertEqual(ch_2.encrypted_string("abc", 27), "bcd")
        self.assertEqual(ch_2.encrypted_string("hello", 5), "mjqqt")
        self.assertEqual(ch_2.encrypted_string("perl", 26), "perl")


if __name__ == "__main__":
    unittest.main()
