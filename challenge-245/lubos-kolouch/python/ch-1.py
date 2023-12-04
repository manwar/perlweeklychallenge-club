#!/usr/bin/env python

import unittest
from typing import List, Tuple


def sort_language(langs: list[str], popularity: list[int]) -> list[str]:
    combined = sorted(zip(langs, popularity), key=lambda x: x[1])
    return [lang for lang, _ in combined]


# Test Cases
class TestSortLanguage(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(
            sort_language(["perl", "c", "python"], [2, 1, 3]), ["c", "perl", "python"]
        )

    def test_example_2(self):
        self.assertEqual(
            sort_language(["c++", "haskell", "java"], [1, 3, 2]),
            ["c++", "java", "haskell"],
        )


if __name__ == "__main__":
    unittest.main()
