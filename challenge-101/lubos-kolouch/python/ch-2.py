#!/usr/bin/env python3
"""
Perl Weekly Challenge 101 - Task 2: Origin-containing Triangle

Given 3 points A, B and C, determine whether the triangle contains the origin
(0,0) in its interior or on its boundary. Return 1 if it does, otherwise 0.
"""

from __future__ import annotations

from typing import Sequence, Tuple


Point = Tuple[int, int]


def _cross(ax: int, ay: int, bx: int, by: int) -> int:
    return ax * by - ay * bx


def contains_origin(a: Point, b: Point, c: Point) -> int:
    """Return 1 if origin is inside/on triangle ABC, else 0."""
    ox, oy = 0, 0

    def sign(p1: Point, p2: Point) -> int:
        return _cross(p2[0] - p1[0], p2[1] - p1[1], ox - p1[0], oy - p1[1])

    s1 = sign(a, b)
    s2 = sign(b, c)
    s3 = sign(c, a)

    has_pos = (s1 > 0) or (s2 > 0) or (s3 > 0)
    has_neg = (s1 < 0) or (s2 < 0) or (s3 < 0)

    return 1 if not (has_pos and has_neg) else 0


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 6:
        raise SystemExit(f"Usage: {__file__} x1 y1 x2 y2 x3 y3")
    x1, y1, x2, y2, x3, y3 = map(int, argv)
    print(contains_origin((x1, y1), (x2, y2), (x3, y3)))


def _run_tests() -> None:
    import unittest

    class TestChallenge101Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(contains_origin((0, 1), (1, 0), (2, 2)), 0)

        def test_example_2(self) -> None:
            self.assertEqual(contains_origin((1, 1), (-1, 1), (0, -3)), 1)

        def test_example_3(self) -> None:
            self.assertEqual(contains_origin((0, 1), (2, 0), (-6, 0)), 1)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge101Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

