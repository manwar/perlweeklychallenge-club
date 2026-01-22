#!/usr/bin/env python3
"""
Perl Weekly Challenge 357 - Task 2: Unique Fraction Generator

Given a positive integer N, generate all unique fractions you can create using
integers from 1 to N:

- Use numbers 1 through N only (no zero)
- Create fractions like numerator/denominator
- List them in ascending order
- If two fractions have the same value (like 1/2 and 2/4), only show the one
  with the smallest numerator (i.e. the reduced form)
"""

from __future__ import annotations

from fractions import Fraction
from typing import List, Sequence


def unique_fractions(n: int) -> List[str]:
    """Return unique reduced fractions from 1..n, ordered by numeric value."""
    if n <= 0:
        raise ValueError("n must be positive")

    fracs: set[Fraction] = set()
    for num in range(1, n + 1):
        for den in range(1, n + 1):
            fracs.add(Fraction(num, den))

    ordered = sorted(fracs)
    return [f"{f.numerator}/{f.denominator}" for f in ordered]


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return

    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <N>")

    n = int(argv[0])
    print(", ".join(unique_fractions(n)))


def _run_tests() -> None:
    import unittest

    class TestChallenge357Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(
                unique_fractions(3),
                ["1/3", "1/2", "2/3", "1/1", "3/2", "2/1", "3/1"],
            )

        def test_example_2(self) -> None:
            self.assertEqual(
                unique_fractions(4),
                ["1/4", "1/3", "1/2", "2/3", "3/4", "1/1", "4/3", "3/2", "2/1", "3/1", "4/1"],
            )

        def test_example_3(self) -> None:
            self.assertEqual(unique_fractions(1), ["1/1"])

        def test_example_4(self) -> None:
            self.assertEqual(
                unique_fractions(6),
                [
                    "1/6",
                    "1/5",
                    "1/4",
                    "1/3",
                    "2/5",
                    "1/2",
                    "3/5",
                    "2/3",
                    "3/4",
                    "4/5",
                    "5/6",
                    "1/1",
                    "6/5",
                    "5/4",
                    "4/3",
                    "3/2",
                    "5/3",
                    "2/1",
                    "5/2",
                    "3/1",
                    "4/1",
                    "5/1",
                    "6/1",
                ],
            )

        def test_example_5(self) -> None:
            self.assertEqual(
                unique_fractions(5),
                [
                    "1/5",
                    "1/4",
                    "1/3",
                    "2/5",
                    "1/2",
                    "3/5",
                    "2/3",
                    "3/4",
                    "4/5",
                    "1/1",
                    "5/4",
                    "4/3",
                    "3/2",
                    "5/3",
                    "2/1",
                    "5/2",
                    "3/1",
                    "4/1",
                    "5/1",
                ],
            )

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge357Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

