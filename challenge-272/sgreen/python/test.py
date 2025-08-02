#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.defang_ip('1.1.1.1'), '1[.]1[.]1[.]1')
        self.assertEqual(ch_1.defang_ip('255.101.1.0'), '255[.]101[.]1[.]0')

    def test_ch_2(self):
        self.assertEqual(ch_2.string_store('hello'), 13)
        self.assertEqual(ch_2.string_store('perl'), 30)
        self.assertEqual(ch_2.string_store('raku'), 37)


if __name__ == '__main__':
    unittest.main()
