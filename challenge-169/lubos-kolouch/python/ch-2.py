#!/usr/bin/env python3
"""Achilles Numbers - Perl Weekly Challenge 169 task 2.

Generate the first N Achilles numbers.

An Achilles number is powerful (all prime exponents >= 2) but not a perfect
power (gcd of exponents is 1).
"""

from __future__ import annotations

from collections.abc import Sequence
import math
import sys
import unittest


def _factor_exponents(n: int) -> list[int]:
    """Return exponents in the prime factorization of n."""
    exps: list[int] = []
    x = n
    p = 2
    while p * p <= x:
        if x % p == 0:
            e = 0
            while x % p == 0:
                x //= p
                e += 1
            exps.append(e)
        p = 3 if p == 2 else p + 2
    if x > 1:
        exps.append(1)
    return exps


def is_achilles_number(n: int) -> bool:
    """Return True if n is an Achilles number."""
    exps = _factor_exponents(n)
    if not exps:
        return False
    if min(exps) < 2:
        return False
    g = 0
    for e in exps:
        g = math.gcd(g, e)
    return g == 1


def achilles_numbers(count: int) -> list[int]:
    """Return the first `count` Achilles numbers."""
    if count <= 0:
        raise ValueError("Expected count > 0")
    out: list[int] = []
    n = 1
    while len(out) < count:
        n += 1
        if is_achilles_number(n):
            out.append(n)
    return out


class AchillesNumbersExamples(unittest.TestCase):
    """Spec-based tests using the provided output list."""

    def test_first_20(self) -> None:
        self.assertEqual(
            achilles_numbers(20),
            [72, 108, 200, 288, 392, 432, 500, 648, 675, 800, 864, 968, 972, 1125, 1152, 1323, 1352, 1372, 1568, 1800],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <count>")
    count = int(args[0])
    print(", ".join(str(x) for x in achilles_numbers(count)))


if __name__ == "__main__":
    main()

