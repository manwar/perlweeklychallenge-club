#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.no_connection([['B', 'C'], ['D','B'], ['C','A']]), 'A'
        )
        self.assertEqual(ch_1.no_connection([['A', 'Z']]), 'Z')

    def test_ch_2(self):
        self.assertEqual(ch_2.making_change(9), 2)
        self.assertEqual(ch_2.making_change(15), 6)
        self.assertEqual(ch_2.making_change(100), 292)


if __name__ == '__main__':
    unittest.main()
