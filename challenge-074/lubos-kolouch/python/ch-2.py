#!/usr/bin/env python3
"""Perl Weekly Challenge 074 - Task 2: FNR Character.

Find the dynamically tracked first non-repeating character (or '#') as characters arrive.
"""

from __future__ import annotations

import unittest


def get_fnr(in_str: str) -> str:
    """Find and return the FNR sequence for the given input string.

    :param in_str: Input sequence of characters.
    :return: String of current FNR characters or '#' at each position.
    """
    fnr_count: dict[str, int] = {}
    fnr_queue: list[str] = []
    result = []

    for char in in_str:
        fnr_count[char] = fnr_count.get(char, 0) + 1

        if fnr_count[char] == 1:
            fnr_queue.append(char)
        elif char in fnr_queue:
            fnr_queue.remove(char)

        result.append(fnr_queue[-1] if fnr_queue else "#")

    return "".join(result)


class TestFnrCharacter(unittest.TestCase):
    """Test cases for get_fnr."""

    def test_example_1(self) -> None:
        self.assertEqual(get_fnr("ababc"), "abb#c")

    def test_example_2(self) -> None:
        self.assertEqual(get_fnr("xyzzyx"), "xyzyx#")

    def test_empty(self) -> None:
        self.assertEqual(get_fnr(""), "")

    def test_single(self) -> None:
        self.assertEqual(get_fnr("a"), "a")

    def test_duplicates(self) -> None:
        self.assertEqual(get_fnr("aa"), "a#")


if __name__ == "__main__":
    unittest.main()
