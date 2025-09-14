#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        matrix_1 = [
            [4,  4, 4, 4],
            [10, 0, 0, 0],
            [2,  2, 2, 9]
        ]

        matrix_2 = [[1, 5],[7, 3], [3, 5]]
        matrix_3 = [[1, 2, 3], [3, 2, 1]]
        matrix_4 = [[2, 8, 7], [7, 1, 3], [1, 9, 5]]
        matrix_5 = [
            [10, 20,  30],
            [5,  5,   5],
            [0,  100, 0],
            [25, 25,  25]
        ]

        self.assertEqual(ch_1.highest_row(matrix_1), 16)
        self.assertEqual(ch_1.highest_row(matrix_2), 10)
        self.assertEqual(ch_1.highest_row(matrix_3), 6)
        self.assertEqual(ch_1.highest_row(matrix_4), 17)
        self.assertEqual(ch_1.highest_row(matrix_5), 100)

    def test_ch_2(self):
        self.assertEqual(ch_2.max_distance([4, 5, 7],[9, 1, 3, 4]), 6)
        self.assertEqual(ch_2.max_distance([2, 3, 5, 4],[3, 2, 5, 5, 8, 7]), 6)
        self.assertEqual(ch_2.max_distance([2, 1, 11, 3],[2, 5, 10, 2]), 9)
        self.assertEqual(ch_2.max_distance([1, 2, 3],[3, 2, 1]), 2)
        self.assertEqual(ch_2.max_distance([1, 0, 2, 3],[5, 0]), 5)


if __name__ == '__main__':
    unittest.main()
