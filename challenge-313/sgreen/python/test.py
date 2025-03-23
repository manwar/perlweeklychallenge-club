#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.broken_keys('perl','perrrl'))
        self.assertTrue(ch_1.broken_keys('raku','rrakuuuu'))
        self.assertFalse(ch_1.broken_keys('python','perl'))
        self.assertTrue(ch_1.broken_keys('coffeescript','cofffeescccript'))

    def test_ch_2(self):
        self.assertEqual(ch_2.reversed_letters('p-er?l'), 'l-re?p')
        self.assertEqual(ch_2.reversed_letters('wee-k!L-y'), 'yLk-e!e-w')
        self.assertEqual(ch_2.reversed_letters('_c-!h_all-en!g_e'), '_e-!g_nel-la!h_c')


if __name__ == '__main__':
    unittest.main()
