#!/usr/bin/env python3
"""Knight's Move - Perl Weekly Challenge 281 task 2."""

from __future__ import annotations

from collections import deque
from collections.abc import Sequence
import sys
import unittest


def _parse_pos(pos: str) -> tuple[int, int]:
    p = pos.strip().lower()
    if len(p) != 2 or p[0] < "a" or p[0] > "h" or p[1] < "1" or p[1] > "8":
        raise ValueError("Expected coordinates like a1..h8")
    x = ord(p[0]) - ord("a")
    y = int(p[1]) - 1
    return x, y


def knights_move(start: str, end: str) -> int:
    """Return the minimum number of knight moves from start to end (8x8 board)."""
    sx, sy = _parse_pos(start)
    ex, ey = _parse_pos(end)
    if (sx, sy) == (ex, ey):
        return 0

    moves = (
        (2, 1),
        (2, -1),
        (-2, 1),
        (-2, -1),
        (1, 2),
        (1, -2),
        (-1, 2),
        (-1, -2),
    )

    dist = [[-1 for _ in range(8)] for _ in range(8)]
    dist[sx][sy] = 0
    q: deque[tuple[int, int]] = deque([(sx, sy)])

    while q:
        x, y = q.popleft()
        d = dist[x][y]
        for dx, dy in moves:
            nx, ny = x + dx, y + dy
            if nx < 0 or nx > 7 or ny < 0 or ny > 7:
                continue
            if dist[nx][ny] != -1:
                continue
            dist[nx][ny] = d + 1
            if (nx, ny) == (ex, ey):
                return dist[nx][ny]
            q.append((nx, ny))

    raise RuntimeError("Unreachable position on a chessboard")


class KnightsMoveExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(knights_move("g2", "a8"), 4)

    def test_example_2(self) -> None:
        self.assertEqual(knights_move("g2", "h2"), 3)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-2.py <start> <end>")
    start, end = args
    print(f"Input:  $start = '{start}', $end = '{end}'")
    print(f"Output: {knights_move(start, end)}")


if __name__ == "__main__":
    main()

