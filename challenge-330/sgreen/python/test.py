#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.clear_digits("cab12"), "c")
        self.assertEqual(ch_1.clear_digits("xy99"), "")
        self.assertEqual(ch_1.clear_digits("pa1erl"), "perl")

    def test_ch_2(self):
        self.assertEqual(ch_2.title_capital("PERL IS gREAT"), "Perl is Great")
        self.assertEqual(ch_2.title_capital("THE weekly challenge"), "The Weekly Challenge")
        self.assertEqual(ch_2.title_capital("YoU ARE A stAR"), "You Are a Star")


if __name__ == '__main__':
    unittest.main()
