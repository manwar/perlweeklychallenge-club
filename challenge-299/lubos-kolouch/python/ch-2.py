#!/usr/bin/env python3
"""Word Search - Perl Weekly Challenge 299 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


Grid = Sequence[Sequence[str]]


def word_search(grid: Grid, text: str) -> bool:
    """Return True if text can be found as an orthogonal path in grid."""
    if not text:
        return True
    rows = len(grid)
    cols = len(grid[0])
    if any(len(row) != cols for row in grid):
        raise ValueError("Non-rectangular grid")

    visited = [[False] * cols for _ in range(rows)]

    def dfs(r: int, c: int, idx: int) -> bool:
        if idx == len(text):
            return True
        if r < 0 or r >= rows or c < 0 or c >= cols:
            return False
        if visited[r][c]:
            return False
        if grid[r][c] != text[idx]:
            return False

        visited[r][c] = True
        ok = (
            dfs(r + 1, c, idx + 1)
            or dfs(r - 1, c, idx + 1)
            or dfs(r, c + 1, idx + 1)
            or dfs(r, c - 1, idx + 1)
        )
        visited[r][c] = False
        return ok

    for r in range(rows):
        for c in range(cols):
            if dfs(r, c, 0):
                return True
    return False


class WordSearchExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        grid = (
            ("A", "B", "D", "E"),
            ("C", "B", "C", "A"),
            ("B", "A", "A", "D"),
            ("D", "B", "B", "C"),
        )
        self.assertTrue(word_search(grid, "BDCA"))

    def test_example_2(self) -> None:
        grid = (
            ("A", "A", "B", "B"),
            ("C", "C", "B", "A"),
            ("C", "A", "A", "A"),
            ("B", "B", "B", "B"),
        )
        self.assertFalse(word_search(grid, "ABAC"))

    def test_example_3(self) -> None:
        grid = (
            ("B", "A", "B", "A"),
            ("C", "C", "C", "C"),
            ("A", "B", "A", "B"),
            ("B", "B", "A", "A"),
        )
        self.assertTrue(word_search(grid, "CCCAA"))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <string>")

    grid = (
        ("A", "B", "D", "E"),
        ("C", "B", "C", "A"),
        ("B", "A", "A", "D"),
        ("D", "B", "B", "C"),
    )
    result = "true" if word_search(grid, args[0]) else "false"
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
