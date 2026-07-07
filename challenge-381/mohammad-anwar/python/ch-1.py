#!/usr/bin/env python3

import unittest

def valid_square(matrix):
    n = len(matrix)

    for row in matrix:
        seen = set(row)
        if len(seen) != n or not all(1 <= x <= n for x in seen):
            return 0

    for col_idx in range(n):
        seen = set()
        for row_idx in range(n):
            seen.add(matrix[row_idx][col_idx])

        if len(seen) != n or not all(1 <= x <= n for x in seen):
            return 0

    return 1

examples = [
    {
        "in": [[1, 2, 3, 4], [2, 3, 4, 1], [3, 4, 1, 2], [4, 1, 2, 3]],
        "out": 1
    },
    {
        "in": [[1]],
        "out": 1
    },
    {
        "in": [[1, 2, 5], [5, 1, 2], [2, 5, 1]],
        "out": 0
    },
    {
        "in": [[1, 2, 3], [1, 2, 3], [1, 2, 3]],
        "out": 0
    },
    {
        "in": [[1, 2, 3], [3, 1, 2], [3, 2, 1]],
        "out": 0
    },
]

class TestValidSquare(unittest.TestCase):
    def test_all_examples(self):
        for ex in examples:
            self.assertEqual(valid_square(ex["in"]), ex["out"])

if __name__ == "__main__":
    unittest.main()
