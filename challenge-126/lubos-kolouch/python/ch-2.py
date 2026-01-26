#!/usr/bin/env python3
"""
Perl Weekly Challenge 126 - Task 2: Minesweeper Game

Given a rectangle grid containing 'x' (mine) and '*' (empty), return a grid
where each '*' is replaced by the count of mines in its 8-neighbourhood.
Mines remain as 'x'.
"""

from __future__ import annotations

from typing import List, Sequence


Grid = List[List[str]]


def _parse_grid(lines: Sequence[str]) -> Grid:
    grid: Grid = []
    for line in lines:
        row = line.strip().split()
        if row:
            grid.append(row)
    if not grid:
        raise ValueError("empty grid")
    width = len(grid[0])
    if any(len(r) != width for r in grid):
        raise ValueError("ragged grid")
    return grid


def minesweeper_counts(grid: Grid) -> Grid:
    """Return a new grid with mine counts for '*' cells."""
    h = len(grid)
    w = len(grid[0])

    out: Grid = [["" for _ in range(w)] for _ in range(h)]
    for r in range(h):
        for c in range(w):
            if grid[r][c] == "x":
                out[r][c] = "x"
                continue

            cnt = 0
            for dr in (-1, 0, 1):
                for dc in (-1, 0, 1):
                    if dr == 0 and dc == 0:
                        continue
                    rr = r + dr
                    cc = c + dc
                    if 0 <= rr < h and 0 <= cc < w and grid[rr][cc] == "x":
                        cnt += 1
            out[r][c] = str(cnt)
    return out


def _format_grid(grid: Grid) -> str:
    return "\n".join(" ".join(row) for row in grid)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit(f"Usage: {__file__}  # runs tests only")


def _run_tests() -> None:
    import unittest

    class TestChallenge126Task2(unittest.TestCase):
        def test_example(self) -> None:
            inp = _parse_grid(
                [
                    "x * * * x * x x x x",
                    "* * * * * * * * * x",
                    "* * * * x * x * x *",
                    "* * * x x * * * * *",
                    "x * * * x * * * * x",
                ]
            )
            expected = _parse_grid(
                [
                    "x 1 0 1 x 2 x x x x",
                    "1 1 0 2 2 4 3 5 5 x",
                    "0 0 1 3 x 3 x 2 x 2",
                    "1 1 1 x x 4 1 2 2 2",
                    "x 1 1 3 x 2 0 0 1 x",
                ]
            )
            self.assertEqual(minesweeper_counts(inp), expected)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge126Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

