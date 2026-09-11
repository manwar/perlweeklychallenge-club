#!/usr/bin/env python3
"""Perl Weekly Challenge 390 - Task 2: Smallest String.

Choose one of first k letters and append to end until lexicographically
smallest.
"""

from __future__ import annotations

import unittest


def smallest_string(s: str, k: int) -> str:
    """Return the lexicographically smallest string reachable by moving one of the first k characters to the end.

    :param s: Input string.
    :param k: Number of leading characters from which one can be moved.
    :return: Lexicographically smallest string.
    """
    if len(s) <= 1:
        return s

    if k > 1:
        return "".join(sorted(s))

    smallest = s
    curr = s
    for _ in range(len(s) - 1):
        curr = curr[1:] + curr[0]
        if curr < smallest:
            smallest = curr

    return smallest


class TestSmallestString(unittest.TestCase):
    """Test cases for smallest_string."""

    def test_example_1(self) -> None:
        self.assertEqual(smallest_string("dbca", 1), "adbc")

    def test_example_2(self) -> None:
        self.assertEqual(smallest_string("geeks", 2), "eegks")

    def test_example_3(self) -> None:
        self.assertEqual(smallest_string("cbaed", 3), "abcde")

    def test_example_4(self) -> None:
        self.assertEqual(smallest_string("fedcba", 4), "abcdef")

    def test_example_5(self) -> None:
        self.assertEqual(smallest_string("perl", 1), "erlp")

    def test_example_6(self) -> None:
        self.assertEqual(smallest_string("oloolooo", 1), "looloooo")

    def test_example_7(self) -> None:
        self.assertEqual(smallest_string("oloooolo", 1), "looloooo")


if __name__ == "__main__":
    unittest.main()
