#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.counter_integers("the1weekly2challenge2"), [1, 2])
        self.assertEqual(ch_1.counter_integers("go21od1lu5c7k"), [21, 1, 5, 7])
        self.assertEqual(ch_1.counter_integers("4p3e2r1l"), [4, 3, 2, 1])

    def test_ch_2(self):
        self.assertEqual(ch_2.nice_string("YaaAho"), "aaA")
        self.assertEqual(ch_2.nice_string("cC"), "cC")
        self.assertEqual(ch_2.nice_string("A"), None)


if __name__ == "__main__":
    unittest.main()
