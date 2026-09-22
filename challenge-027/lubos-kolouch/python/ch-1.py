#!/usr/bin/env python3
"""Perl Weekly Challenge 027 - Task 1: Intersection of Two Straight Lines.

Find the intersection of two straight lines given endpoints (a,b)-(c,d) and (p,q)-(r,s).
"""

from __future__ import annotations

import unittest


def get_intersection(
    a: float,
    b: float,
    c: float,
    d: float,
    p: float,
    q: float,
    r: float,
    s: float,
) -> tuple[float, float] | None:
    """Calculate the intersection point of two infinitely long 2D lines.

    Line 1 passes through (a, b) and (c, d).
    Line 2 passes through (p, q) and (r, s).

    :return: (px, py) tuple if lines intersect, None if parallel or coincident.
    """
    det = (a - c) * (q - s) - (b - d) * (p - r)
    if det == 0:
        return None

    term1 = a * d - b * c
    term2 = p * s - q * r

    px = (term1 * (p - r) - (a - c) * term2) / det
    py = (term1 * (q - s) - (b - d) * term2) / det

    return (px, py)


class TestIntersection(unittest.TestCase):
    """Test cases for get_intersection."""

    def test_example_1(self) -> None:
        self.assertEqual(
            get_intersection(0, 0, 2, 0, -4, -5, 8, 1),
            (6.0, 0.0),
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            get_intersection(0, 0, 2, 0, -4, -5, 8, 0),
            (8.0, 0.0),
        )

    def test_example_3(self) -> None:
        self.assertEqual(
            get_intersection(0, 0, 2, 1, -4, -5, 2, 1),
            (2.0, 1.0),
        )

    def test_parallel(self) -> None:
        self.assertIsNone(get_intersection(1, 2, 3, 4, 5, 6, 7, 8))


if __name__ == "__main__":
    unittest.main()
