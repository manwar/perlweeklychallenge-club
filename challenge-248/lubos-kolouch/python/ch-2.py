#!/usr/bin/env python

import unittest
from typing import List


def construct_matrix(a: list[list[int]]) -> list[list[int]]:
    n, m = len(a), len(a[0])
    b = [
        [
            sum(a[i + di][j + dj] for di in range(2) for dj in range(2))
            for j in range(m - 1)
        ]
        for i in range(n - 1)
    ]
    return b


class TestConstructMatrix(unittest.TestCase):
    def test_case_1(self):
        self.assertEqual(
            construct_matrix([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]),
            [[14, 18, 22], [30, 34, 38]],
        )

    def test_case_2(self):
        self.assertEqual(
            construct_matrix([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]),
            [[2, 1, 0], [1, 2, 1], [0, 1, 2]],
        )


if __name__ == "__main__":
    unittest.main()
