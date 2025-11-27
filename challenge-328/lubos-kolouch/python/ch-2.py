#!/usr/bin/env python3
"""
Task: Good String (Weekly Challenge 328)

Remove adjacent pairs of the same letter in opposite cases until none
remain. Return the resulting good string.
"""
from __future__ import annotations

import unittest


def good_string(text: str) -> str:
    stack: list[str] = []
    for ch in text:
        if stack and stack[-1].lower() == ch.lower() and stack[-1] != ch:
            stack.pop()
        else:
            stack.append(ch)
    return "".join(stack)


class GoodStringTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(good_string("WeEeekly"), "Weekly")
        self.assertEqual(good_string("abBAdD"), "")
        self.assertEqual(good_string("abc"), "abc")


if __name__ == "__main__":
    unittest.main()
