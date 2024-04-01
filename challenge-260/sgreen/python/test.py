#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.uniq_occurrences([1, 2, 2, 1, 1, 3]))
        self.assertFalse(ch_1.uniq_occurrences([1, 2, 3]))
        self.assertTrue(ch_1.uniq_occurrences([-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]))

    def test_ch_2(self):
        self.assertEqual(ch_2.dictionary_rank('CAT'), 3)
        self.assertEqual(ch_2.dictionary_rank('GOOGLE'), 88)
        self.assertEqual(ch_2.dictionary_rank('SECRET'), 255)


if __name__ == '__main__':
    unittest.main()
