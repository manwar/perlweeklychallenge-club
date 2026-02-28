#!/usr/bin/env python3
"""Perl Weekly Challenge 004 Task 1: PI digits by script size."""

from __future__ import annotations

from decimal import Decimal, getcontext
import os
import sys
import unittest


def _pi_text(min_digits: int) -> str:
    """Compute PI text with at least `min_digits` significant digits."""
    extra = 12
    getcontext().prec = min_digits + extra

    c = Decimal(426880) * Decimal(10005).sqrt()
    m = 1
    linear_term = 13591409
    x = 1
    k = 6
    s = Decimal(linear_term)

    terms = (min_digits // 14) + 2
    for i in range(1, terms):
        m = (m * (k * k * k - 16 * k)) // (i * i * i)
        linear_term += 545140134
        x *= -262537412640768000
        s += Decimal(m * linear_term) / Decimal(x)
        k += 12

    return format(c / s, "f")


def pi_prefix(size: int) -> str:
    """Return PI with `size` digits (excluding '.') and no rounding."""
    pi_text = _pi_text(size + 2)
    return pi_text[: size + 1]  # plus decimal point


class Task1SpecTests(unittest.TestCase):
    """Example-based test from the specification."""

    def test_size_10(self) -> None:
        self.assertEqual(pi_prefix(10), "3.141592653")


def main(argv: list[str] | None = None) -> None:
    """CLI entry point."""
    args = sys.argv[1:] if argv is None else argv
    if args and args[0] == "--test":
        unittest.main(argv=[sys.argv[0]])
        return

    script_size = os.path.getsize(__file__)
    print(pi_prefix(script_size))


if __name__ == "__main__":
    main()
