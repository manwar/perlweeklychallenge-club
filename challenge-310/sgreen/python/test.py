#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.array_intersection([[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]]), [1, 4])
        self.assertEqual(ch_1.array_intersection([[1, 0, 2, 3], [2, 4, 5]]), [2])
        self.assertEqual(ch_1.array_intersection([[1, 2, 3], [4, 5], [6]]), [])

    def test_ch_2(self):
        self.assertEqual(ch_2.sort_odd_even([4, 1, 2, 3]), [2, 3, 4, 1])
        self.assertEqual(ch_2.sort_odd_even([3, 1]), [3, 1])
        self.assertEqual(ch_2.sort_odd_even([5, 3, 2, 1, 4]), [2, 3, 4, 1, 5])


if __name__ == '__main__':
    unittest.main()
