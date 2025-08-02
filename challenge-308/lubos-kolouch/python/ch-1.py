#!/usr/bin/env python3
"""
Task 1: Count Common

Given two arrays of strings, str1 and str2,
return the count of common strings in both arrays.

Examples:
  Input: str1 = ["perl", "weekly", "challenge"]
         str2 = ["raku", "weekly", "challenge"]
  Output: 2

  Input: str1 = ["perl", "raku", "python"]
         str2 = ["python", "java"]
  Output: 1

  Input: str1 = ["guest", "contribution"]
         str2 = ["fun", "weekly", "challenge"]
  Output: 0

"""

import unittest

# typedef: Define a type alias for list of strings.
StrList = list[str]


def count_common(str1: StrList, str2: StrList) -> int:
    """
    Count the number of common strings between two lists.
    """
    return len(set(str1).intersection(str2))


class TestCountCommon(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(
            count_common(["perl", "weekly", "challenge"],
                         ["raku", "weekly", "challenge"]), 2)

    def test_example2(self):
        self.assertEqual(
            count_common(["perl", "raku", "python"], ["python", "java"]), 1)

    def test_example3(self):
        self.assertEqual(
            count_common(["guest", "contribution"],
                         ["fun", "weekly", "challenge"]), 0)


if __name__ == '__main__':
    unittest.main()
