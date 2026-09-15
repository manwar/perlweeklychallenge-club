#!/usr/bin/env python3

import unittest

def median(arrays):
    m   = sorted([item for sublist in arrays for item in sublist])
    mid = len(m) // 2
    return float(m[mid]) if len(m) % 2 != 0 else (m[mid - 1] + m[mid]) / 2.0

class TestMedian(unittest.TestCase):
    def test_examples(self):
        examples = [
            {"in": [[2], [4]], "out": 3.0},
            {"in": [[1, 2, 3], [7, 8, 9, 10]], "out": 7.0},
            {"in": [[], [10, 20, 30, 40]], "out": 25.0},
            {"in": [[100], [1, 2, 3, 4, 5, 6, 7]], "out": 4.5},
            {"in": [[1, 2, 2], [2, 2, 3]], "out": 2.0},
        ]
        for ex in examples:
            self.assertEqual(median(ex["in"]), ex["out"])

if __name__ == "__main__":
    unittest.main()
