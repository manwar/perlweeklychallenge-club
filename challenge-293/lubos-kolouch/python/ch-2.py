#!/usr/bin/env python3
"""Boomerang - Perl Weekly Challenge 293 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def is_boomerang(points: Sequence[Sequence[int]]) -> str:
    """Return 'true' if the 3 points form a boomerang (distinct, non-collinear), 'false' otherwise."""
    if len(points) != 3:
        raise ValueError("Exactly three points are required")

    point_set = {tuple(p) for p in points}
    if len(point_set) < 3:
        return "false"

    (x1, y1), (x2, y2), (x3, y3) = points
    determinant = (x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1)

    return "false" if determinant == 0 else "true"


class TestBoomerang(unittest.TestCase):
    """Unit tests for is_boomerang."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(is_boomerang([[1, 1], [2, 3], [3, 2]]), "true")

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(is_boomerang([[1, 1], [2, 2], [3, 3]]), "false")

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(is_boomerang([[1, 1], [1, 2], [2, 3]]), "true")

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(is_boomerang([[1, 1], [1, 2], [1, 3]]), "false")

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(is_boomerang([[1, 1], [2, 1], [3, 1]]), "false")

    def test_example6(self) -> None:
        """Test example 6."""
        self.assertEqual(is_boomerang([[0, 0], [2, 3], [4, 5]]), "true")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    _ = argv
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
