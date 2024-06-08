#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.magic_number([3, 7, 5], [9, 5, 7]), 2)
        self.assertEqual(ch_1.magic_number([1, 2, 1], [5, 4, 4]), 3)
        self.assertEqual(ch_1.magic_number([2], [5]), 3)

    def test_ch_2(self):
        self.assertEqual(ch_2.numbers_game([2, 5, 3, 4]), [3, 2, 5, 4])
        self.assertEqual(
            ch_2.numbers_game([9, 4, 1, 3, 6, 4, 6, 1]),
            [1, 1, 4, 3, 6, 4, 9, 6]
        )
        self.assertEqual(ch_2.numbers_game([1, 2, 2, 3]), [2, 1, 3, 2])


if __name__ == '__main__':
    unittest.main()
