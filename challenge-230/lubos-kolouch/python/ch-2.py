#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List
import unittest


def count_prefix(words: List[str], prefix: str) -> int:
    count = 0
    for word in words:
        if word.startswith(prefix):
            count += 1
    return count


class TestCountPrefix(unittest.TestCase):
    def test_example1(self):
        words = ["pay", "attention", "practice", "attend"]
        prefix = "at"
        expected = 2
        self.assertEqual(count_prefix(words, prefix), expected)

    def test_example2(self):
        words = ["janet", "julia", "java", "javascript"]
        prefix = "ja"
        expected = 3
        self.assertEqual(count_prefix(words, prefix), expected)


if __name__ == "__main__":
    unittest.main()
