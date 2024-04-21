#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.appearance_33([1, 2, 3, 3, 3, 3, 4, 2]), 3)
        self.assertEqual(ch_1.appearance_33([1, 1]), 1)
        self.assertEqual(ch_1.appearance_33([1, 2, 3]), 1)

    def test_ch_2(self):
        self.assertEqual(
            ch_2.completing_word('aBc 11c', ['accbbb', 'abc', 'abbc']),
            'accbbb'
        )
        self.assertEqual(
            ch_2.completing_word('Da2 abc', ['abcm', 'baacd', 'abaadc']),
            'baacd'
        )
        self.assertEqual(
            ch_2.completing_word('JB 007', ['jj', 'bb', 'bjb']),
            'bjb'
        )


if __name__ == '__main__':
    unittest.main()
