#!/usr/bin/env python3

import re
import unittest

def second_largest_digit(string):
    digits = re.findall(r"\d", string)

    unique = set(digits)
    sorted_digits = sorted([int(d) for d in unique], reverse=True)

    return -1 if len(sorted_digits) < 2 else sorted_digits[1]

class TestSecondLargestDigit(unittest.TestCase):

    def test_examples(self):
        examples = [
            {"in": "aaaaa77777", "out": -1},
            {"in": "abcde", "out": -1},
            {"in": "9zero8eight7seven9", "out": 8},
            {"in": "xyz9876543210", "out": 8},
            {"in": "4abc4def2ghi8jkl2", "out": 4},
        ]

        for example in examples:
            self.assertEqual(second_largest_digit(example["in"]), example["out"])

if __name__ == "__main__":
    unittest.main()
