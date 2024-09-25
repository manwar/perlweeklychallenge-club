#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.strong_password('a'), 5)
        self.assertEqual(ch_1.strong_password('aB2'), 3)
        self.assertEqual(ch_1.strong_password('PaaSW0rd'), 0)
        self.assertEqual(ch_1.strong_password('Paaasw0rd'), 1)
        self.assertEqual(ch_1.strong_password('aaaaa'), 2)

    def test_ch_2(self):
        self.assertTrue(ch_2.valid_number('1'))
        self.assertFalse(ch_2.valid_number('a'))
        self.assertFalse(ch_2.valid_number('.'))
        self.assertFalse(ch_2.valid_number('1.2e4.2'))
        self.assertTrue(ch_2.valid_number('-1'))
        self.assertTrue(ch_2.valid_number('+1E-8'))
        self.assertTrue(ch_2.valid_number('.44'))


if __name__ == '__main__':
    unittest.main()
