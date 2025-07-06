#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.replace_all_questions('a?z'), 'abz')
        self.assertEqual(ch_1.replace_all_questions('pe?k'), 'peak')
        self.assertEqual(ch_1.replace_all_questions('gra?te'), 'grabte')
        self.assertEqual(ch_1.replace_all_questions('gra?be'), 'gracbe')

    def test_ch_2(self):
        self.assertEqual(ch_2.good_string('WeEeekly'), 'Weekly')
        self.assertEqual(ch_2.good_string('abBAdD'), '')
        self.assertEqual(ch_2.good_string('abc'), 'abc')


if __name__ == '__main__':
    unittest.main()
