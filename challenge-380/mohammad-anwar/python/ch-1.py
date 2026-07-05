#!/usr/bin/env python3

import re
import unittest


def sum_of_freq(string):
    v, c = {}, {}

    for char in string.lower():
        if re.match(r"[aeiou]", char):
            v[char] = v.get(char, 0) + 1
        elif re.match(r"[a-z]", char):
            c[char] = c.get(char, 0) + 1

    return max(v.values(), default=0) + max(c.values(), default=0)


class TestSumOfFreq(unittest.TestCase):
    def test_examples(self):
        examples = [
            {"in": "banana", "out": 5},
            {"in": "teestett", "out": 7},
            {"in": "aeiouuaa", "out": 3},
            {"in": "rhythm", "out": 2},
            {"in": "x", "out": 1},
        ]

        for ex in examples:
            with self.subTest(string=ex["in"]):
                self.assertEqual(sum_of_freq(ex["in"]), ex["out"])

if __name__ == "__main__":
    unittest.main()
