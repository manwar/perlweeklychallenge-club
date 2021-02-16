#!/usr/bin/env python3

import unittest
from ch1 import pattern_match

class TestTask1(unittest.TestCase):


    def test_example_cases(self):
        self.assertTrue(pattern_match("abcde", "a*e"))
        self.assertFalse(pattern_match("abcde", "a*d"))
        self.assertFalse(pattern_match("abcde", "?b*d"))
        self.assertTrue(pattern_match("abcde", "a*c?e"))


if __name__ == '__main__':
    unittest.main()
