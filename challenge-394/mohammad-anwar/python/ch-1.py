#!/usr/bin/env python3

import unittest

def min_swaps(string):
    chars = list(string)

    def calc(start_lower):
        swaps = 0
        target = 0
        for i, char in enumerate(chars):
            is_lower = 1 if 'a' <= char <= 'z' else 0
            if is_lower == start_lower:
                swaps += abs(i - target)
                target += 2
        return swaps

    return min(calc(1), calc(0))


class TestMinSwaps(unittest.TestCase):

    def test_examples(self):
        examples = [
            {"in": "aAbB",   "out": 0},
            {"in": "AAbb",   "out": 1},
            {"in": "AAAbbb", "out": 3},
            {"in": "aABb",   "out": 1},
            {"in": "aBBAaa", "out": 2},
        ]
        for example in examples:
            with self.subTest(example=example):
                self.assertEqual(min_swaps(example["in"]), example["out"])


if __name__ == "__main__":
    unittest.main()
