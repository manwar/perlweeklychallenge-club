#!/usr/bin/env python3
"""
Task: Counter Integers (Weekly Challenge 329)

Replace all non-digit characters with spaces, collect the integers, and
return the distinct values in order of first appearance.
"""
from __future__ import annotations

from typing import List
import unittest


def counter_integers(text: str) -> List[int]:
    """Return distinct integers (in order) after removing non-digits."""
    digits_as_spaces = "".join(ch if ch.isdigit() else " " for ch in text)
    seen = set()
    result: List[int] = []
    for chunk in digits_as_spaces.split():
        if chunk not in seen:
            seen.add(chunk)
            result.append(int(chunk))
    return result


class CounterIntegersTests(unittest.TestCase):
    def test_examples(self) -> None:
        self.assertEqual(counter_integers("the1weekly2challenge2"), [1, 2])
        self.assertEqual(counter_integers("go21od1lu5c7k"), [21, 1, 5, 7])
        self.assertEqual(counter_integers("4p3e2r1l"), [4, 3, 2, 1])


if __name__ == "__main__":
    unittest.main()
