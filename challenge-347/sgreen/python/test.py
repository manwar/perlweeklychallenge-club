#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.format_date('1st Jan 2025'), '2025-01-01')
        self.assertEqual(ch_1.format_date('22nd Feb 2025'), '2025-02-22')
        self.assertEqual(ch_1.format_date('15th Apr 2025'), '2025-04-15')
        self.assertEqual(ch_1.format_date('23rd Oct 2025'), '2025-10-23')
        self.assertEqual(ch_1.format_date('31st Dec 2025'), '2025-12-31')

    def test_ch_2(self):
        self.assertEqual(ch_2.format_phone('1-23-45-6'), '123-456')
        self.assertEqual(ch_2.format_phone('1234'), '12-34')
        self.assertEqual(ch_2.format_phone('12 345-6789'), '123-456-789')
        self.assertEqual(ch_2.format_phone('123 4567'), '123-45-67')
        self.assertEqual(ch_2.format_phone('123 456-78'), '123-456-78')


if __name__ == '__main__':
    unittest.main()
