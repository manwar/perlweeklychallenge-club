#!/usr/bin/env python3
"""
Perl Weekly Challenge 361 - Task 2: Find Celebrity

You are given a binary matrix (n x n).

Find the celebrity, or return -1 if none exists.

A celebrity is someone who is known by everyone and knows nobody.
"""

from __future__ import annotations

from typing import Sequence


def find_celebrity(party: Sequence[Sequence[int]]) -> int:
    """Return the celebrity index, or -1 if none exists."""
    n = len(party)
    if n == 0:
        return -1

    cand = 0
    for i in range(1, n):
        if party[cand][i] == 1:
            cand = i

    for i in range(n):
        if i == cand:
            continue
        if party[cand][i] == 1:
            return -1
        if party[i][cand] == 0:
            return -1
    return cand


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit("Run without arguments to execute the embedded tests.")


def _run_tests() -> None:
    import unittest

    class TestChallenge361Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            party = [
                [0, 0, 0, 0, 1, 0],
                [0, 0, 0, 0, 1, 0],
                [0, 0, 0, 0, 1, 0],
                [0, 0, 0, 0, 1, 0],
                [0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 1, 0],
            ]
            self.assertEqual(find_celebrity(party), 4)

        def test_example_2(self) -> None:
            party = [
                [0, 1, 0, 0],
                [0, 0, 1, 0],
                [0, 0, 0, 1],
                [1, 0, 0, 0],
            ]
            self.assertEqual(find_celebrity(party), -1)

        def test_example_3(self) -> None:
            party = [
                [0, 0, 0, 0, 0],
                [1, 0, 0, 0, 0],
                [1, 0, 0, 0, 0],
                [1, 0, 0, 0, 0],
                [1, 0, 0, 0, 0],
            ]
            self.assertEqual(find_celebrity(party), 0)

        def test_example_4(self) -> None:
            party = [
                [0, 1, 0, 1, 0, 1],
                [1, 0, 1, 1, 0, 0],
                [0, 0, 0, 1, 1, 0],
                [0, 0, 0, 0, 0, 0],
                [0, 1, 0, 1, 0, 0],
                [1, 0, 1, 1, 0, 0],
            ]
            self.assertEqual(find_celebrity(party), 3)

        def test_example_5(self) -> None:
            party = [
                [0, 1, 1, 0],
                [1, 0, 1, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
            ]
            self.assertEqual(find_celebrity(party), -1)

        def test_example_6(self) -> None:
            party = [
                [0, 0, 1, 1],
                [1, 0, 0, 0],
                [1, 1, 0, 1],
                [1, 1, 0, 0],
            ]
            self.assertEqual(find_celebrity(party), -1)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge361Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

