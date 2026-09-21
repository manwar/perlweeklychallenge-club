#!/usr/bin/env python3
"""Perl Weekly Challenge 392 - Task 1: Make Palindrome.

Convert given string to palindrome by adding minimum characters in front of it.
"""

from __future__ import annotations

import unittest


def make_palindrome(s: str) -> str:
    """Convert given string to shortest palindrome by prepending characters.

    Finds the longest palindromic prefix of s, and prepends the reversed
    remaining suffix.

    :param s: Input string.
    :return: Shortest palindrome formed by prepending characters.
    """
    if len(s) <= 1:
        return s

    n = len(s)
    for length in range(n, 0, -1):
        prefix = s[:length]
        if prefix == prefix[::-1]:
            suffix_to_add = s[length:]
            return suffix_to_add[::-1] + s

    return s[1:][::-1] + s


class TestMakePalindrome(unittest.TestCase):
    """Test cases for make_palindrome."""

    def test_example_1(self) -> None:
        self.assertEqual(make_palindrome("pinnipeds"), "sdepinnipeds")

    def test_example_2(self) -> None:
        self.assertEqual(make_palindrome("abcd"), "dcbabcd")

    def test_example_3(self) -> None:
        self.assertEqual(make_palindrome("bananas"), "sananabananas")

    def test_example_4(self) -> None:
        self.assertEqual(make_palindrome("dissident"), "tnedissident")

    def test_example_5(self) -> None:
        self.assertEqual(make_palindrome("cailliachs"), "shcailliachs")

    def test_already_palindrome(self) -> None:
        self.assertEqual(make_palindrome("racecar"), "racecar")

    def test_single_char(self) -> None:
        self.assertEqual(make_palindrome("a"), "a")


if __name__ == "__main__":
    unittest.main()
