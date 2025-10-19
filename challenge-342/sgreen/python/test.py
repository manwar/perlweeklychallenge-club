#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.balance_string("a0b1c2"), "0a1b2c")
        self.assertEqual(ch_1.balance_string("abc12"), "a1b2c")
        self.assertEqual(ch_1.balance_string("0a2b1c3"), "0a1b2c3")
        self.assertEqual(ch_1.balance_string("1a23"), "")
        self.assertEqual(ch_1.balance_string("ab123"), "1a2b3")

    def test_ch_2(self):
        self.assertEqual(ch_2.max_score("0011"), 4)
        self.assertEqual(ch_2.max_score("0000"), 3)
        self.assertEqual(ch_2.max_score("1111"), 3)
        self.assertEqual(ch_2.max_score("0101"), 3)
        self.assertEqual(ch_2.max_score("011101"), 5)


if __name__ == '__main__':
    unittest.main()
