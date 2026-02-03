#!/usr/bin/env python3
"""
Perl Weekly Challenge 106 - Task 2: Decimal String

Convert a fraction N/D into its decimal representation string.
If the fractional part is recurring, wrap the repeating part in parentheses.
"""

from __future__ import annotations

from typing import Dict, List, Sequence


def decimal_string(n: int, d: int) -> str:
    if d == 0:
        raise ZeroDivisionError("denominator must be non-zero")

    sign = "-" if (n < 0) ^ (d < 0) else ""
    n = abs(n)
    d = abs(d)

    integer = n // d
    rem = n % d
    if rem == 0:
        return f"{sign}{integer}"

    seen_at: Dict[int, int] = {}
    digits: List[str] = []

    while rem != 0 and rem not in seen_at:
        seen_at[rem] = len(digits)
        rem *= 10
        digits.append(str(rem // d))
        rem %= d

    if rem == 0:
        return f"{sign}{integer}." + "".join(digits)

    start = seen_at[rem]
    nonrep = "".join(digits[:start])
    rep = "".join(digits[start:])
    return f"{sign}{integer}.{nonrep}({rep})"


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <N> <D>")
    print(decimal_string(int(argv[0]), int(argv[1])))


def _run_tests() -> None:
    import unittest

    class TestChallenge106Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(decimal_string(1, 3), "0.(3)")

        def test_example_2(self) -> None:
            self.assertEqual(decimal_string(1, 2), "0.5")

        def test_example_3(self) -> None:
            self.assertEqual(decimal_string(5, 66), "0.0(75)")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge106Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

