#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.lucky_integer([2, 2, 3, 4]), 2)
        self.assertEqual(ch_1.lucky_integer([1, 2, 2, 3, 3, 3]), 3)
        self.assertEqual(ch_1.lucky_integer([1, 1, 1, 3]), -1)

    def test_ch_2(self):
        self.assertEqual(
            ch_2.relative_sort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5],
                               [2, 1, 4, 3, 5, 6]),
            [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9]
        )
        self.assertEqual(
            ch_2.relative_sort([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2]),
            [1, 3, 3, 3, 2, 2, 4, 4, 6]
        )
        self.assertEqual(
            ch_2.relative_sort([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2]),
            [1, 1, 1, 0, 0, 3, 2, 4, 5]
        )


if __name__ == '__main__':
    unittest.main()
