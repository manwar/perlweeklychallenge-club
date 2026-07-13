#!/usr/bin/env python3
"""Hamiltonian Cycle - Perl Weekly Challenge 382 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def hamiltonian_cycle(n: int) -> list[int]:
    """Return a circle of numbers 1..n where adjacent pairs sum to perfect squares."""
    if n < 1:
        return []
    if n == 1:
        return []

    # Precompute squares up to 2n
    squares = set()
    i = 1
    while i * i <= 2 * n:
        squares.add(i * i)
        i += 1

    # Build adjacency list
    adj: dict[int, list[int]] = {u: [] for u in range(1, n + 1)}
    for u in range(1, n + 1):
        for v in range(1, n + 1):
            if u == v:
                continue
            if (u + v) in squares:
                adj[u].append(v)

    path = [1]
    visited = {1}

    def dfs(u: int) -> bool:
        if len(path) == n:
            # Check if the last and first elements add up to a perfect square
            if (path[-1] + 1) in squares:
                return True
            return False

        for v in adj[u]:
            if v not in visited:
                visited.add(v)
                path.append(v)
                if dfs(v):
                    return True
                path.pop()
                visited.remove(v)
        return False

    if dfs(1):
        return path
    return []


class HamiltonianCycleExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        res = hamiltonian_cycle(32)
        self.assertEqual(len(res), 32)
        # Check squares
        squares = {i * i for i in range(1, 20)}
        for idx in range(32):
            self.assertIn(res[idx] + res[(idx + 1) % 32], squares)

    def test_example_2(self) -> None:
        self.assertEqual(hamiltonian_cycle(15), [])


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-1.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
