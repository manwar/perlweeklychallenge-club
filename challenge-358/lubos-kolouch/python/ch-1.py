#!/usr/bin/env python3
"""
Perl Weekly Challenge 358 - Task 1: Max Str Value

Given an array of alphanumeric strings, compute each string's value:
  - if it contains digits only: its numeric value (leading zeros allowed)
  - otherwise: the length of the string

Return the maximum value.
"""

from __future__ import annotations

from typing import Sequence


def str_value(s: str) -> int:
    """Return numeric value for digit-only strings, otherwise length."""
    return int(s) if s.isdigit() else len(s)


def max_str_value(strings: Sequence[str]) -> int:
    """Return maximum value among the given strings."""
    if not strings:
        raise ValueError("expected at least one string")
    return max(str_value(s) for s in strings)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    print(max_str_value(argv))


def _run_tests() -> None:
    import unittest

    class TestChallenge358Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(max_str_value(["123", "45", "6"]), 123)

        def test_example_2(self) -> None:
            self.assertEqual(max_str_value(["abc", "de", "fghi"]), 4)

        def test_example_3(self) -> None:
            self.assertEqual(max_str_value(["0012", "99", "a1b2c"]), 99)

        def test_example_4(self) -> None:
            self.assertEqual(max_str_value(["x", "10", "xyz", "007"]), 10)

        def test_example_5(self) -> None:
            self.assertEqual(max_str_value(["hello123", "2026", "perl"]), 2026)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge358Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

