#!/usr/bin/env python3

import unittest

examples = [
    {"in": "pinnipeds",  "out": "sdepinnipeds"},
    {"in": "abcd",       "out": "dcbabcd"},
    {"in": "bananas",    "out": "sananabananas"},
    {"in": "dissident",  "out": "tnedissident"},
    {"in": "cailliachs", "out": "shcailliachs"},
]

def convert_palindrome(s):
    for length in range(len(s), 0, -1):
        prefix = s[0:length]
        if prefix == prefix[::-1]:
            return s[length:][::-1] + s

class TestConvertPalindrome(unittest.TestCase):
    def test_examples(self):
        for case in examples:
            self.assertEqual(convert_palindrome(case["in"]), case["out"])

if __name__ == "__main__":
    unittest.main()
