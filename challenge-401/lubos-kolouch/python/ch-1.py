#!/usr/bin/env python3
"""Fractional Addition Substraction - Perl Weekly Challenge 401, Task 1."""

from __future__ import annotations

import math
import re
import unittest

_FRACTION_RE = re.compile(r"([+-]?\d+)/(\d+)")


def fraction_addition(expr: str) -> str:
    """Evaluate a fraction addition/subtraction expression and return reduced 'num/den'."""
    num = 0
    den = 1

    for match in _FRACTION_RE.finditer(expr):
        n = int(match.group(1))
        d = int(match.group(2))
        num = num * d + n * den
        den *= d
        g = math.gcd(abs(num), den)
        num //= g
        den //= g

    return f"{num}/{den}"


class TestFractionAddition(unittest.TestCase):
    """Unit tests for the fraction_addition function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[str, str]] = [
            ("1/2+3/2", "2/1"),
            ("-5/2-3/2", "-4/1"),
            ("5/3-5/3", "0/1"),
            ("10/10-1/10+2/5", "13/10"),
            ("1/6+1/6+1/6", "1/2"),
        ]
        for expr, expected in cases:
            with self.subTest(expr=expr):
                self.assertEqual(fraction_addition(expr), expected)


if __name__ == "__main__":
    unittest.main()
