#!/usr/bin/env python3
"""Word Squares - Perl Weekly Challenge 395 task 2."""

from __future__ import annotations

from collections import defaultdict
from collections.abc import Sequence
import sys
import unittest


def word_squares(words: Sequence[str]) -> list[str]:
    """Find an N x N word square from the given words."""
    if not words:
        return []

    n = len(words[0])
    for w in words:
        if len(w) != n:
            raise ValueError("All words must have the same length")

    prefix_map: dict[str, list[str]] = defaultdict(list)
    for w in words:
        for length in range(n + 1):
            prefix_map[w[:length]].append(w)

    current_square: list[str] = []
    result: list[str] | None = None

    def search(step: int) -> bool:
        nonlocal result
        if result is not None:
            return True
        if step == n:
            result = list(current_square)
            return True

        required_prefix = "".join(current_square[row][step] for row in range(step))
        for word in prefix_map.get(required_prefix, []):
            current_square.append(word)
            if search(step + 1):
                return True
            current_square.pop()
        return False

    search(0)
    return result if result is not None else []


class TestWordSquares(unittest.TestCase):
    """Unit tests for word_squares."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(word_squares(["MA", "AM", "MY", "ME"]), ["MA", "AM"])

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(
            word_squares(["SUN", "USE", "NET", "SEE", "TEN"]),
            ["SUN", "USE", "NET"],
        )

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(
            word_squares(["BOAT", "TEAL", "AREA", "TSAR", "OGRE"]),
            ["BOAT", "OGRE", "AREA", "TEAL"],
        )

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(
            word_squares(["CARD", "AREA", "REAR", "DART"]),
            ["CARD", "AREA", "REAR", "DART"],
        )

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(
            word_squares(["HEART", "TREND", "EMBER", "RESIN", "ABUSE"]),
            ["HEART", "EMBER", "ABUSE", "RESIN", "TREND"],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        out = word_squares(argv[1:])
        print(f"Output: ({', '.join(repr(x) for x in out)})")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
