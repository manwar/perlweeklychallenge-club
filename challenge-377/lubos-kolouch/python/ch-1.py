#!/usr/bin/env python3
"""Perl Weekly Challenge 377 - Task 1: Reverse Substring.

Find whether any substring of length 2 of $str is present in reverse($str).
"""

from __future__ import annotations

import unittest


def has_reverse_substring(s: str) -> bool:
    """Return True if any length 2 substring of s is present in reverse(s).

    :param s: Input string.
    :return: True if a common length 2 substring exists, False otherwise.
    """
    if len(s) < 2:
        return False

    rev = s[::-1]
    for i in range(len(s) - 1):
        sub = s[i : i + 2]
        if sub in rev:
            return True

    return False


class TestReverseSubstring(unittest.TestCase):
    """Test cases for has_reverse_substring."""

    def test_example_1(self) -> None:
        self.assertTrue(has_reverse_substring("abcba"))

    def test_example_2(self) -> None:
        self.assertTrue(has_reverse_substring("racecar"))

    def test_example_3(self) -> None:
        self.assertFalse(has_reverse_substring("abcd"))

    def test_example_4(self) -> None:
        self.assertTrue(has_reverse_substring("banana"))

    def test_example_5(self) -> None:
        self.assertTrue(has_reverse_substring("hello"))


if __name__ == "__main__":
    unittest.main()
