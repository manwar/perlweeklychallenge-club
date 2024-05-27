#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.special_positions([[1, 0, 0], [0, 0, 1], [1, 0, 0]]), 1
        )
        self.assertEqual(
            ch_1.special_positions([[1, 0, 0], [0, 1, 0], [0, 0, 1]]), 3
        )

    def test_ch_2(self):
        self.assertEqual(ch_2.equalize_array([4, 1], 3, 2), 9)
        self.assertEqual(ch_2.equalize_array([2, 3, 3, 3, 5], 2, 1), 6)


if __name__ == '__main__':
    unittest.main()
