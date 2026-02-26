#!/usr/bin/env python3

import unittest

def echo_chamber(s):
    result = ""
    for i, char in enumerate(s):
        result += char * (i + 1)
    return result

class TestEchoChamber(unittest.TestCase):

    def setUp(self):
        self.examples = {
            "abca": "abbcccaaaa",
            "xyz": "xyyzzz",
            "code": "coodddeeee",
            "hello": "heelllllllooooo",
            "a": "a",
        }

    def test_examples(self):
        for input_str, expected in self.examples.items():
            with self.subTest(input=input_str):
                self.assertEqual(echo_chamber(input_str), expected)

if __name__ == "__main__":
    unittest.main()
