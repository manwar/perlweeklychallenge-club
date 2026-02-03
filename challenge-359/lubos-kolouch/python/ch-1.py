#!/usr/bin/env python3
"""
Perl Weekly Challenge 359 - Task 1: Digital Root

Given a positive integer, compute:
  - additive persistence: how many digit-sum iterations to reach a single digit
  - digital root: the final single digit reached
"""

from __future__ import annotations

from typing import Sequence, Tuple


def digital_root_and_persistence(value: int) -> Tuple[int, int]:
    """Return (persistence, digital_root) for the given positive integer."""
    if value < 1:
        raise ValueError("value must be a positive integer")

    persistence = 0
    x = value
    while x >= 10:
        x = sum(int(ch) for ch in str(x))
        persistence += 1
    return persistence, x


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <int>")
    p, dr = digital_root_and_persistence(int(argv[0]))
    print(f"Persistence  = {p}")
    print(f"Digital Root = {dr}")


def _run_tests() -> None:
    import unittest

    class TestChallenge359Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(digital_root_and_persistence(38), (2, 2))

        def test_example_2(self) -> None:
            self.assertEqual(digital_root_and_persistence(7), (0, 7))

        def test_example_3(self) -> None:
            self.assertEqual(digital_root_and_persistence(999), (2, 9))

        def test_example_4(self) -> None:
            self.assertEqual(digital_root_and_persistence(1999999999), (3, 1))

        def test_example_5(self) -> None:
            self.assertEqual(digital_root_and_persistence(101010), (1, 3))

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge359Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

