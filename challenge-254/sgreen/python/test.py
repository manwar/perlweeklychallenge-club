#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.three_power(27))
        self.assertTrue(ch_1.three_power(0))
        self.assertFalse(ch_1.three_power(6))

    def test_ch_2(self):
        self.assertEqual(ch_2.reverse_vowels('Raku'), 'Ruka')
        self.assertEqual(ch_2.reverse_vowels('Perl'), 'Perl')
        self.assertEqual(ch_2.reverse_vowels('Julia'), 'Jaliu')
        self.assertEqual(ch_2.reverse_vowels('Uiua'), 'Auiu')


if __name__ == '__main__':
    unittest.main()
