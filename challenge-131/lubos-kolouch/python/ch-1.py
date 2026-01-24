#!/usr/bin/env python3
"""
Perl Weekly Challenge 131 - Task 1: Consecutive Arrays

You are given a sorted list of unique positive integers.
Return a list of arrays where each array contains consecutive integers.
"""

from __future__ import annotations

from typing import List, Sequence


def consecutive_arrays(values: Sequence[int]) -> List[List[int]]:
    """Group sorted unique integers into sublists of consecutive integers."""
    if not values:
        return []

    out: List[List[int]] = []
    current: List[int] = [values[0]]

    for v in values[1:]:
        if v == current[-1] + 1:
            current.append(v)
        else:
            out.append(current)
            current = [v]

    out.append(current)
    return out


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit(f"Usage: {__file__}  # runs tests only")


def _run_tests() -> None:
    import unittest

    class TestChallenge131Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(consecutive_arrays([1, 2, 3, 6, 7, 8, 9]), [[1, 2, 3], [6, 7, 8, 9]])

        def test_example_2(self) -> None:
            self.assertEqual(consecutive_arrays([11, 12, 14, 17, 18, 19]), [[11, 12], [14], [17, 18, 19]])

        def test_example_3(self) -> None:
            self.assertEqual(consecutive_arrays([2, 4, 6, 8]), [[2], [4], [6], [8]])

        def test_example_4(self) -> None:
            self.assertEqual(consecutive_arrays([1, 2, 3, 4, 5]), [[1, 2, 3, 4, 5]])

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge131Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

