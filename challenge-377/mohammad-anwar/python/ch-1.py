#!/usr/bin/env python3

import unittest

def reverse_substr_exists(string):
    rev = string[::-1]
    for i in range(len(string) - 1):
        sub = string[i:i+2]
        if rev.find(sub) != -1:
            return "true"
    return "false"

examples = [
    { "in": "abcba",   "out": "true"  },
    { "in": "racecar", "out": "true"  },
    { "in": "abcd",    "out": "false" },
    { "in": "banana",  "out": "true"  },
    { "in": "hello",   "out": "true"  },
]

class TestReverseSubstr(unittest.TestCase):
    def test_examples(self):
        for example in examples:
            with self.subTest(example=example):
                self.assertEqual(reverse_substr_exists(example["in"]), example["out"])

if __name__ == "__main__":
    unittest.main()
