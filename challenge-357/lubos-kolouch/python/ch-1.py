#!/usr/bin/env python3
"""
Perl Weekly Challenge 357 - Task 1: Kaprekar Constant

Write a function that takes a 4-digit integer and returns how many iterations
are required to reach Kaprekar’s constant (6174). If the sequence does not
converge on 6174, return -1.
"""

from __future__ import annotations

from typing import Sequence


def kaprekar_iterations(value: int) -> int:
    """Return iterations needed to reach 6174 (or -1 if it never converges)."""
    if value < 0 or value > 9999:
        raise ValueError("value must be in range 0..9999")

    seen: set[int] = set()
    steps = 0

    while value != 6174:
        if value in seen:
            return -1
        seen.add(value)

        digits = f"{value:04d}"
        asc = int("".join(sorted(digits)))
        desc = int("".join(sorted(digits, reverse=True)))
        value = desc - asc
        steps += 1

    return steps


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return

    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <4-digit-int>")

    print(kaprekar_iterations(int(argv[0])))


def _run_tests() -> None:
    import unittest

    class TestChallenge357Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(kaprekar_iterations(3524), 3)

        def test_example_2(self) -> None:
            self.assertEqual(kaprekar_iterations(6174), 0)

        def test_example_3(self) -> None:
            self.assertEqual(kaprekar_iterations(9998), 5)

        def test_example_4(self) -> None:
            self.assertEqual(kaprekar_iterations(1001), 4)

        def test_example_5(self) -> None:
            self.assertEqual(kaprekar_iterations(9000), 4)

        def test_example_6(self) -> None:
            self.assertEqual(kaprekar_iterations(1111), -1)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge357Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

