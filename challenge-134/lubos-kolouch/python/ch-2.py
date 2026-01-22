#!/usr/bin/env python3
"""
Perl Weekly Challenge 134 - Task 2: Distinct Terms Count

Given two positive integers m and n, generate the multiplication table (n rows,
m columns) and display the count of distinct terms.

The examples show:
  m=3, n=3 -> 6 distinct terms
  m=3, n=5 -> 11 distinct terms
"""

from __future__ import annotations

from typing import Sequence, Set, Tuple


def distinct_terms_count(m: int, n: int) -> int:
    """Return the number of distinct values in the n-by-m multiplication table."""
    if m <= 0 or n <= 0:
        raise ValueError("m and n must be positive integers")

    terms: Set[int] = set()
    for i in range(1, n + 1):
        for j in range(1, m + 1):
            terms.add(i * j)
    return len(terms)


def distinct_terms(m: int, n: int) -> Tuple[int, list[int]]:
    """Return (count, sorted list of distinct terms)."""
    if m <= 0 or n <= 0:
        raise ValueError("m and n must be positive integers")
    terms = sorted({i * j for i in range(1, n + 1) for j in range(1, m + 1)})
    return len(terms), terms


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <m> <n>")
    m = int(argv[0])
    n = int(argv[1])
    count, values = distinct_terms(m, n)
    print(f"Distinct Terms: {', '.join(map(str, values))}")
    print(f"Count: {count}")


def _run_tests() -> None:
    import unittest

    class TestChallenge134Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(distinct_terms_count(3, 3), 6)

        def test_example_2(self) -> None:
            self.assertEqual(distinct_terms_count(3, 5), 11)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge134Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

