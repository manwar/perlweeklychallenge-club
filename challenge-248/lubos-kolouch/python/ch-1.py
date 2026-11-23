#!/usr/bin/env python3
"""Shortest Distance - Perl Weekly Challenge 248, Task 1."""

from __future__ import annotations

import unittest


def shortest_distance(s: str, char: str) -> list[int]:
    """Return shortest distance to char for each index in s."""
    if not s:
        return []

    positions = [i for i, c in enumerate(s) if c == char]
    if not positions:
        raise ValueError(f"Character {char!r} not found in string")

    return [min(abs(i - pos) for pos in positions) for i in range(len(s))]


class TestShortestDistance(unittest.TestCase):
    """Unit tests for the shortest_distance function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[str, str, list[int]]] = [
            ("loveleetcode", "e", [3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0]),
            ("aaab", "b", [3, 2, 1, 0]),
        ]
        for s, char, expected in cases:
            with self.subTest(s=s, char=char):
                self.assertEqual(shortest_distance(s, char), expected)


if __name__ == "__main__":
    unittest.main()
