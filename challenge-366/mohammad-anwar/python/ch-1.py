#!/usr/bin/env python3

import unittest

def count_prefixes(string, array):
    count = sum(1 for word in array if string.startswith(word))
    return count

class TestCountPrefixes(unittest.TestCase):
    def test_examples(self):
        examples = [
            {
                "str": "apple",
                "array": ["a", "ap", "app", "apple", "banana"],
                "out": 4
            },
            {
                "str": "bird",
                "array": ["cat", "dog", "fish"],
                "out": 0
            },
            {
                "str": "hello",
                "array": ["hello", "he", "hell", "heaven", "he"],
                "out": 4
            },
            {
                "str": "coding",
                "array": ["", "code", "coding", "cod"],
                "out": 3
            },
            {
                "str": "program",
                "array": ["p", "pr", "pro", "prog", "progr", "progra", "program"],
                "out": 7
            },
        ]

        for example in examples:
            with self.subTest(example=example):
                result = count_prefixes(example["str"], example["array"])
                self.assertEqual(result, example["out"])

if __name__ == "__main__":
    unittest.main()
