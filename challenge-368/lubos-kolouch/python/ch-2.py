#!/usr/bin/env python3
"""Big and Little Omega - Perl Weekly Challenge 368 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def factorize(n: int) -> list[int]:
    """Return all prime factors of *n* (including duplicates)."""
    factors: list[int] = []
    d = 2
    while d * d <= n:
        while n % d == 0:
            factors.append(d)
            n //= d
        d += 1
    if n > 1:
        factors.append(n)
    return factors


def omega(number: int, mode: int) -> int:
    """
    Count prime factors.

    *mode* = 0 (little omega): count of distinct prime factors
    *mode* = 1 (big omega):    count of all prime factors including duplicates
    """
    factors = factorize(number)
    return len(set(factors)) if mode == 0 else len(factors)


class BigLittleOmegaExamples(unittest.TestCase):
    """Example-based tests from the challenge specification."""

    def test_example_1(self) -> None:
        self.assertEqual(omega(100061, 0), 3)

    def test_example_2(self) -> None:
        self.assertEqual(omega(971088, 0), 3)

    def test_example_3(self) -> None:
        self.assertEqual(omega(63640, 1), 6)

    def test_example_4(self) -> None:
        self.assertEqual(omega(988841, 1), 2)

    def test_example_5(self) -> None:
        self.assertEqual(omega(211529, 0), 2)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-2.py <number> <mode>")

    number = int(args[0])
    mode = int(args[1])
    result = omega(number, mode)
    print(f"Input:  $number = {number}, $mode = {mode}")
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
