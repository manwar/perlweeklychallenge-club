#!/usr/bin/env python3
"""
Task: Nice String (Weekly Challenge 329)

Return the longest substring where every present letter appears in both
lowercase and uppercase. If none exists, return the empty string.
"""
from __future__ import annotations

import unittest


def is_nice(s: str) -> bool:
    chars = set(s)
    return all(c.lower() in chars and c.upper() in chars for c in chars)


def longest_nice_substring(s: str) -> str:
    best = ""
    n = len(s)
    for i in range(n):
        for j in range(i + 1, n + 1):
            candidate = s[i:j]
            if len(candidate) <= len(best):
                continue
            if is_nice(candidate):
                best = candidate
    return best


class NiceStringTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(longest_nice_substring("YaaAho"), "aaA")
        self.assertEqual(longest_nice_substring("cC"), "cC")
        self.assertEqual(longest_nice_substring("A"), "")


if __name__ == "__main__":
    unittest.main()
