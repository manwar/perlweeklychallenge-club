#!/usr/bin/env python3
"""
Perl Weekly Challenge 123 - Task 2: Square Points

Given coordinates of four points, determine if they form a square.
Return 1 if they do, otherwise 0.
"""

from __future__ import annotations

from typing import Sequence, Tuple


Point = Tuple[int, int]


def _dist2(a: Point, b: Point) -> int:
    return (a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2


def is_square(points: Sequence[Point]) -> int:
    if len(points) != 4:
        raise ValueError("expected 4 points")

    dists: list[int] = []
    for i in range(4):
        for j in range(i + 1, 4):
            dists.append(_dist2(points[i], points[j]))
    dists.sort()

    if dists[0] == 0:
        return 0
    if not (dists[0] == dists[1] == dists[2] == dists[3]):
        return 0
    if dists[4] != dists[5]:
        return 0
    return 1 if dists[4] == 2 * dists[0] else 0


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 8:
        raise SystemExit(f"Usage: {__file__} x1 y1 x2 y2 x3 y3 x4 y4")
    coords = list(map(int, argv))
    pts = [(coords[0], coords[1]), (coords[2], coords[3]), (coords[4], coords[5]), (coords[6], coords[7])]
    print(is_square(pts))


def _run_tests() -> None:
    import unittest

    class TestChallenge123Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            pts = [(10, 20), (20, 20), (20, 10), (10, 10)]
            self.assertEqual(is_square(pts), 1)

        def test_example_2(self) -> None:
            pts = [(12, 24), (16, 10), (20, 12), (18, 16)]
            self.assertEqual(is_square(pts), 0)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge123Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

