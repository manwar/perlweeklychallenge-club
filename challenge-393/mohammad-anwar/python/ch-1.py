#!/usr/bin/env python3

import math
import unittest

def count_pythagorean_triplets(n: int) -> int:
    count = 0
    for a in range(1, n + 1):
        for b in range(1, n + 1):
            c = math.sqrt(a * a + b * b)
            if c <= n and c == int(c):
                count += 1
    return count


class TestPythagoreanTriplets(unittest.TestCase):
    def test_examples(self):
        examples = [
            {"in": 20, "out": 12},
            {"in": 7, "out": 2},
            {"in": 1, "out": 0},
            {"in": 15, "out": 8},
            {"in": 30, "out": 22},
        ]

        for example in examples:
            with self.subTest(example=example):
                self.assertEqual(
                    count_pythagorean_triplets(example["in"]), example["out"]
                )


if __name__ == "__main__":
    unittest.main()
