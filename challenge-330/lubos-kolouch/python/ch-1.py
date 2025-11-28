#!/usr/bin/env python3
"""
Task: Clear Digits (Weekly Challenge 330)

Given a string of lowercase letters and digits, remove digits one by one
along with the closest non-digit character to their left. Return the
remaining characters.
"""
from __future__ import annotations

from typing import List
import unittest


def clear_digits(text: str) -> str:
    """Remove each digit and its closest non-digit to the left."""
    stack: List[str] = []
    for ch in text:
        if ch.isdigit():
            if stack:
                stack.pop()
        else:
            stack.append(ch)
    return "".join(stack)


class ClearDigitsTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(clear_digits("cab12"), "c")
        self.assertEqual(clear_digits("xy99"), "")
        self.assertEqual(clear_digits("pa1erl"), "perl")


if __name__ == "__main__":
    unittest.main()
