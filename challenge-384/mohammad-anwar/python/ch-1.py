#!/usr/bin/env python3

import unittest

def to_base(n, b):
    d = [
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        *"ABCDEFGHIJKLMNOPQRSTUVWXYZ",
        *"abcdefghijklmnopqrstuvwxyz",
        "+",
        "/",
    ]
    return to_base(n // b, b) + d[n % b] if n else ""


class TestBaseConversion(unittest.TestCase):
    def test_examples(self):
        examples = [
            {"in": [42, 2], "out": "101010"},
            {"in": [15642094, 16], "out": "EEADEE"},
            {"in": [493, 8], "out": "755"},
            {"in": [2228519, 36], "out": "1BRJB"},
            {"in": [123456789, 64], "out": "7MyqL"},
        ]

        for ex in examples:
            with self.subTest(ex=ex):
                self.assertEqual(to_base(*ex["in"]), ex["out"])


if __name__ == "__main__":
    unittest.main()
