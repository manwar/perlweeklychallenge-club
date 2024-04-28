#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.uncommon_words('Mango is sweet', 'Mango is sour'),
            ['sweet', 'sour']
        )
        self.assertEqual(
            ch_1.uncommon_words('Mango Mango', 'Orange'),
            ['Orange']
        )
        self.assertEqual(
            ch_1.uncommon_words('Mango is Mango', 'Orange is Orange'),
            []
        )

    def test_ch_2(self):
        self.assertTrue(ch_2.x_matrix([
            [1, 0, 0, 2],
            [0, 3, 4, 0],
            [0, 5, 6, 0],
            [7, 0, 0, 1],
        ]))
        self.assertFalse(ch_2.x_matrix([
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
        ]))
        self.assertTrue(ch_2.x_matrix([
            [1, 0, 2],
            [0, 3, 0],
            [4, 0, 5],
        ]))


if __name__ == '__main__':
    unittest.main()
