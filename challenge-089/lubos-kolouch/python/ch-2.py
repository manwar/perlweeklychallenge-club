#!/usr/bin/env python3
"""
Perl Weekly Challenge 089 - Task 2: Magical Matrix

Display a 3x3 matrix using numbers 1..9 exactly once such that all rows,
columns, and both diagonals sum to 15.
"""

from __future__ import annotations

from typing import List, Sequence

Matrix = List[List[int]]


def magical_matrix() -> Matrix:
    """Return a valid 3x3 magic square using 1..9 (Lo Shu square)."""
    return [
        [8, 1, 6],
        [3, 5, 7],
        [4, 9, 2],
    ]


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    m = magical_matrix()
    for row in m:
        print(" ".join(str(x) for x in row))


def _run_tests() -> None:
    import unittest

    class TestChallenge089Task2(unittest.TestCase):
        def test_magic_square_properties(self) -> None:
            m = magical_matrix()
            flat = [x for row in m for x in row]
            self.assertEqual(sorted(flat), list(range(1, 10)))

            self.assertTrue(all(sum(row) == 15 for row in m))
            self.assertTrue(all(sum(m[r][c] for r in range(3)) == 15 for c in range(3)))
            self.assertEqual(m[0][0] + m[1][1] + m[2][2], 15)
            self.assertEqual(m[0][2] + m[1][1] + m[2][0], 15)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge089Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

