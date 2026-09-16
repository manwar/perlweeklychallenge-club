#!/usr/bin/env python3
"""Perl Weekly Challenge 076 - Task 2: Word Search.

Find all words from a list appearing in a 2D grid in any of 8 directions.
"""

from __future__ import annotations

import unittest


def build_search_corpus(grid_lines: list[str]) -> str:
    """Extract all ray strings from the grid in all 8 directions.

    :param grid_lines: List of space-separated row strings.
    :return: Concatenated corpus separated by '#' delimiter.
    """
    if not grid_lines:
        return ""

    real_grid = [line.strip().split() for line in grid_lines if line.strip()]
    if not real_grid or not real_grid[0]:
        return ""

    rows = len(real_grid)
    cols = len(real_grid[0])

    directions = [
        (0, 1),
        (1, 0),
        (1, 1),
        (1, -1),
        (0, -1),
        (-1, 0),
        (-1, -1),
        (-1, 1),
    ]

    strings: list[str] = []
    for r in range(rows):
        for c in range(cols):
            for dr, dc in directions:
                chars: list[str] = []
                cr, cc = r, c
                while 0 <= cr < rows and 0 <= cc < cols:
                    chars.append(real_grid[cr][cc])
                    cr += dr
                    cc += dc
                if chars:
                    strings.append("".join(chars))

    return "#".join(strings)


def find_words(grid_lines: list[str], words: list[str], min_len: int = 1) -> list[str]:
    """Find and return words present in the grid in any of 8 directions.

    :param grid_lines: List of strings defining the grid rows.
    :param words: List of words to search for.
    :param min_len: Minimum word length to consider.
    :return: List of found words.
    """
    corpus = build_search_corpus(grid_lines)
    found: list[str] = []

    for word in words:
        if len(word) < min_len:
            continue
        if word.upper() in corpus:
            found.append(word)

    return found


class TestWordSearch(unittest.TestCase):
    """Test cases for find_words."""

    def setUp(self) -> None:
        self.grid = [
            "B I D E",
            "H E A R",
            "C D E F",
        ]

    def test_horizontal(self) -> None:
        self.assertEqual(
            find_words(self.grid, ["BIDE", "HEAR", "CDEF"]),
            ["BIDE", "HEAR", "CDEF"],
        )

    def test_diagonal(self) -> None:
        self.assertEqual(find_words(self.grid, ["BEE"]), ["BEE"])

    def test_reversed(self) -> None:
        self.assertEqual(find_words(self.grid, ["RAEH"]), ["RAEH"])

    def test_not_found(self) -> None:
        self.assertEqual(find_words(self.grid, ["NONEXISTENT"]), [])


if __name__ == "__main__":
    unittest.main()
