#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        matrix_1 = [
            [1, 0, 1, 0, 0],
            [1, 0, 1, 1, 1],
            [1, 1, 1, 1, 1],
            [1, 0, 0, 1, 0],
        ]

        matrix_2 = [
            [0, 1],
            [1, 0],
        ]

        matrix_3 = [ [ 0 ] ]

        matrix_4 = [
            [ 0, 1, 1, 0, 0],
            [ 0, 1, 1, 1, 1],
            [ 0, 0, 1, 1, 1],
            [ 0, 0, 1, 1, 1],
        ]
        self.assertEqual(ch_1.maximal_square(matrix_1), 4)
        self.assertEqual(ch_1.maximal_square(matrix_2), 1)
        self.assertEqual(ch_1.maximal_square(matrix_3), 0)
        self.assertEqual(ch_1.maximal_square(matrix_4), 9)

    def test_ch_2(self):
        interval_1 = [ [3, 4], [2, 3], [1, 2] ]
        interval_2 = [ [1, 4], [2, 3], [3, 4] ]
        interval_3 = [ [1, 2] ]
        interval_4 = [ [1, 4], [2, 2], [3, 4] ]

        self.assertEqual(ch_2.right_interval(interval_1), [-1, 0, 1])
        self.assertEqual(ch_2.right_interval(interval_2), [-1, 2, -1])
        self.assertEqual(ch_2.right_interval(interval_3), [-1])
        self.assertEqual(ch_2.right_interval(interval_4), [-1, 1, -1])


if __name__ == '__main__':
    unittest.main()
