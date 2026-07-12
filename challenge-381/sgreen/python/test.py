#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        matrix_1 = [
            [1, 2, 3, 4],
            [2, 3, 4, 1],
            [3, 4, 1, 2],
            [4, 1, 2, 3]
        ]
        matrix_2 = [[1]]
        matrix_3 = [
            [1, 2, 5],
            [5, 1, 2],
            [2, 5, 1]
        ]
        matrix_4 = [
            [1, 2, 3],
            [1, 2, 3],
            [1, 2, 3]
        ]
        matrix_5 = [
            [1, 2, 3],
            [3, 1, 2],
            [3, 2, 1]
        ]

        self.assertTrue(ch_1.same_row_column(matrix_1))
        self.assertTrue(ch_1.same_row_column(matrix_2))
        self.assertFalse(ch_1.same_row_column(matrix_3))
        self.assertFalse(ch_1.same_row_column(matrix_4))
        self.assertFalse(ch_1.same_row_column(matrix_5))

    def test_ch_2(self):
        self.assertEqual(ch_2.smaller_greater_element([2, 4]), 0)
        self.assertEqual(ch_2.smaller_greater_element([1, 1, 1, 1]), 0)
        self.assertEqual(ch_2.smaller_greater_element([1, 1, 4, 8, 12, 12]), 2)
        self.assertEqual(ch_2.smaller_greater_element([3, 6, 6, 9]), 2)
        self.assertEqual(ch_2.smaller_greater_element([0, -5, 10, -2, 4]), 3)


if __name__ == "__main__":
    unittest.main()
