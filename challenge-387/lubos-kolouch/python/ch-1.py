#!/usr/bin/env python3
"""Perl Weekly Challenge 387 - Task 1: Rearrange Binary String.

Simultaneously replace all occurrences of "01" with "10" until no "01"
remains, returning the total number of steps.
"""

from __future__ import annotations

import unittest


def rearrange_binary_string(s: str) -> int:
    """Return the number of steps to eliminate all '01' substrings by replacing them with '10' simultaneously.

    :param s: Binary string consisting of '0' and '1'.
    :return: Total number of steps.
    """
    steps = 0
    while "01" in s:
        s = s.replace("01", "10")
        steps += 1
    return steps


class TestRearrangeBinaryString(unittest.TestCase):
    """Test cases for rearrange_binary_string."""

    def test_example_1(self) -> None:
        self.assertEqual(rearrange_binary_string("111000"), 0)

    def test_example_2(self) -> None:
        self.assertEqual(rearrange_binary_string("00011"), 4)

    def test_example_3(self) -> None:
        self.assertEqual(rearrange_binary_string("01011"), 3)

    def test_example_4(self) -> None:
        self.assertEqual(rearrange_binary_string("010101"), 3)

    def test_example_5(self) -> None:
        self.assertEqual(rearrange_binary_string("00001"), 4)


if __name__ == "__main__":
    unittest.main()
