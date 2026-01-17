#!/usr/bin/env python3
"""Largest Square - Perl Weekly Challenge 149 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import math
import sys
import unittest


DIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"


def _to_base(n: int, base: int) -> str:
    if n == 0:
        return "0"
    out: list[str] = []
    x = n
    while x > 0:
        d = x % base
        out.append(DIGITS[d])
        x //= base
    return "".join(reversed(out))


def _digits_unique(n: int, base: int) -> bool:
    seen = [0] * base
    x = n
    while x > 0:
        d = x % base
        seen[d] += 1
        if seen[d] > 1:
            return False
        x //= base
    return True


def largest_square(base: int) -> str:
    """Return largest perfect square with no repeated digits in given base."""
    if base < 2 or base > 36:
        raise ValueError("Expected base between 2 and 36")

    max_value = 0
    for d in range(base - 1, -1, -1):
        max_value = max_value * base + d

    t = int(math.isqrt(max_value))
    while t > 0:
        sq = t * t
        if _digits_unique(sq, base):
            return _to_base(sq, base)
        t -= 1
    return "0"


class LargestSquareExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(largest_square(2), "1")

    def test_example_2(self) -> None:
        self.assertEqual(largest_square(4), "3201")

    def test_example_3(self) -> None:
        self.assertEqual(largest_square(10), "9814072356")

    def test_example_4(self) -> None:
        self.assertEqual(largest_square(12), "B8750A649321")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <base>")
    base = int(args[0])
    print(largest_square(base))


if __name__ == "__main__":
    main()

