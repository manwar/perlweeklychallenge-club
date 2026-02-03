#!/usr/bin/env python3
"""
Perl Weekly Challenge 121 - Task 2: The Travelling Salesman

Given an NxN distance matrix, find a minimum-length round trip starting at city
0, visiting each city exactly once, and returning to 0.

This implementation brute-forces permutations, which is appropriate for small N
(as in the challenge example).
"""

from __future__ import annotations

import itertools
from typing import List, Sequence, Tuple


TourResult = Tuple[int, List[int]]


def tsp_min_tour(matrix: Sequence[Sequence[int]]) -> TourResult:
    n = len(matrix)
    if n == 0 or any(len(row) != n for row in matrix):
        raise ValueError("expected an NxN matrix")
    if n == 1:
        return 0, [0]

    best_len: int | None = None
    best_tour: List[int] = []

    for perm in itertools.permutations(range(1, n)):
        tour = [0, *perm, 0]
        length = sum(matrix[tour[i]][tour[i + 1]] for i in range(n))
        if best_len is None or length < best_len:
            best_len = length
            best_tour = tour

    return int(best_len), best_tour


def _example_matrix() -> List[List[int]]:
    return [
        [0, 5, 2, 7],
        [5, 0, 5, 3],
        [3, 1, 0, 6],
        [4, 5, 4, 0],
    ]


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1 or argv[0] != "run":
        raise SystemExit(f"Usage: {__file__} run")
    length, tour = tsp_min_tour(_example_matrix())
    print(f"length = {length}")
    print(f"tour = ({' '.join(map(str, tour))})")


def _run_tests() -> None:
    import unittest

    class TestChallenge121Task2(unittest.TestCase):
        def test_example(self) -> None:
            length, tour = tsp_min_tour(_example_matrix())
            self.assertEqual(length, 10)
            self.assertEqual(tour, [0, 2, 1, 3, 0])

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge121Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
