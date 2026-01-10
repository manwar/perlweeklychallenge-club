#!/usr/bin/env python3
"""Brilliant Numbers - Perl Weekly Challenge 169 task 1.

Generate the first N brilliant numbers.

Brilliant numbers are numbers that are the product of exactly two primes of the
same decimal length (e.g. 24287 = 149 * 163).
"""

from __future__ import annotations

from collections.abc import Sequence
import math
import sys
import unittest


def _factor_two_primes(n: int) -> tuple[int, int] | None:
    """Return the two prime factors (with multiplicity) if n has exactly 2 prime factors."""
    if n < 2:
        return None

    factors: list[int] = []
    x = n
    p = 2
    while p * p <= x and len(factors) <= 2:
        while x % p == 0:
            factors.append(p)
            x //= p
            if len(factors) > 2:
                return None
        p = 3 if p == 2 else p + 2
    if x > 1:
        factors.append(x)
    if len(factors) != 2:
        return None
    return factors[0], factors[1]


def is_brilliant_number(n: int) -> bool:
    """Return True if n is a brilliant number."""
    factors = _factor_two_primes(n)
    if factors is None:
        return False
    a, b = factors
    return len(str(a)) == len(str(b))


def brilliant_numbers(count: int) -> list[int]:
    """Return the first `count` brilliant numbers."""
    if count <= 0:
        raise ValueError("Expected count > 0")
    out: list[int] = []
    n = 1
    while len(out) < count:
        n += 1
        if is_brilliant_number(n):
            out.append(n)
    return out


class BrilliantNumbersExamples(unittest.TestCase):
    """Spec-based tests using the provided output list."""

    def test_first_20(self) -> None:
        self.assertEqual(
            brilliant_numbers(20),
            [4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221, 247, 253, 289, 299],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py <count>")
    count = int(args[0])
    print(", ".join(str(x) for x in brilliant_numbers(count)))


if __name__ == "__main__":
    main()

