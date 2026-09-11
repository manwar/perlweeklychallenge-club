#!/usr/bin/env python3
"""Perl Weekly Challenge 390 - Task 1: Decode String.

Decode strings encoded as K[encoded_string], where encoded_string inside
brackets is repeated K > 0 times.
"""

from __future__ import annotations

import unittest


def decode_string(s: str) -> str:
    """Decode string formatted with K[encoded_string] repetitions.

    :param s: Encoded input string.
    :return: Fully decoded string.
    """
    count_stack: list[int] = []
    str_stack: list[str] = []
    curr_str = ""
    curr_num = 0

    for char in s:
        if char.isdigit():
            curr_num = curr_num * 10 + int(char)
        elif char == "[":
            count_stack.append(curr_num)
            str_stack.append(curr_str)
            curr_num = 0
            curr_str = ""
        elif char == "]":
            count = count_stack.pop()
            prev_str = str_stack.pop()
            curr_str = prev_str + curr_str * count
        else:
            curr_str += char

    return curr_str


class TestDecodeString(unittest.TestCase):
    """Test cases for decode_string."""

    def test_example_1(self) -> None:
        self.assertEqual(decode_string("2[3[a]]"), "aaaaaa")

    def test_example_2(self) -> None:
        self.assertEqual(decode_string("10[a]"), "aaaaaaaaaa")

    def test_example_3(self) -> None:
        self.assertEqual(decode_string("a2[b]c3[d]e"), "abbcddde")

    def test_example_4(self) -> None:
        self.assertEqual(decode_string("2[a2[b]c]"), "abbcabbc")

    def test_example_5(self) -> None:
        self.assertEqual(decode_string("1[a]2[b3[c]]"), "abcccbccc")


if __name__ == "__main__":
    unittest.main()
