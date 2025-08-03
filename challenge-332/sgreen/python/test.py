#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.binary_date('2025-07-26'),
            '11111101001-111-11010'
        )
        self.assertEqual(
            ch_1.binary_date('2000-02-02'),
            '11111010000-10-10'
        )
        self.assertEqual(
            ch_1.binary_date('2024-12-31'),
            '11111101000-1100-11111'
        )

    def test_ch_2(self):
        self.assertFalse(ch_2.odd_letters('weekly'))
        self.assertTrue(ch_2.odd_letters('perl'))
        self.assertFalse(ch_2.odd_letters('challenge'))


if __name__ == '__main__':
    unittest.main()
