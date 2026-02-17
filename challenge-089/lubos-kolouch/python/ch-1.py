#!/usr/bin/env python3
"""
Perl Weekly Challenge 089 - Task 1: GCD Sum

You are given a positive integer N.

Compute:
  sum(gcd(i, j)) for all unique pairs 1 <= i < j <= N
"""

from __future__ import annotations

from typing import List, Sequence


def _phi_sieve(n: int) -> List[int]:
    phi = list(range(n + 1))
    for p in range(2, n + 1):
        if phi[p] == p:
            for k in range(p, n + 1, p):
                phi[k] -= phi[k] // p
    return phi


def gcd_sum(n: int) -> int:
    """Return sum(gcd(i,j)) over 1 <= i < j <= n."""
    if n < 1:
        raise ValueError("n must be a positive integer")
    if n < 2:
        return 0

    phi = _phi_sieve(n)
    prefix = [0] * (n + 1)
    for i in range(1, n + 1):
        prefix[i] = prefix[i - 1] + phi[i]

    total = 0
    for g in range(1, n + 1):
        m = n // g
        if m >= 2:
            coprime_pairs = prefix[m] - 1  # sum_{k=2..m} phi(k)
            total += g * coprime_pairs
    return total


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <N>")
    print(gcd_sum(int(argv[0])))


def _run_tests() -> None:
    import unittest

    class TestChallenge089Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(gcd_sum(3), 3)

        def test_example_2(self) -> None:
            self.assertEqual(gcd_sum(4), 7)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge089Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

