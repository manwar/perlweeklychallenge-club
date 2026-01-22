#!/usr/bin/env python3
"""
Perl Weekly Challenge 135 - Task 2: Validate SEDOL

Given a 7-character alphanumeric SEDOL, validate it:
  - First 6 characters must be in [0-9, B,C,D,F,G,H,J,K,L,M,N,P,Q,R,S,T,V,W,X,Y,Z]
  - 7th character is a check digit (0-9) computed using the standard weights.

Return 1 if valid, otherwise 0.
"""

from __future__ import annotations

from typing import Sequence


_WEIGHTS: list[int] = [1, 3, 1, 7, 3, 9]
_ALLOWED: set[str] = set("0123456789BCDFGHJKLMNPQRSTVWXYZ")


def _char_value(ch: str) -> int:
    if ch.isdigit():
        return int(ch)
    return ord(ch) - ord("A") + 10


def sedol_check_digit(code6: str) -> int:
    """Return SEDOL check digit for the first 6 characters, or -1 if invalid input."""
    if len(code6) != 6 or any(c not in _ALLOWED for c in code6):
        return -1

    total = 0
    for i, ch in enumerate(code6):
        total += _WEIGHTS[i] * _char_value(ch)
    return (10 - (total % 10)) % 10


def is_valid_sedol(code7: str) -> int:
    """Return 1 if SEDOL is valid else 0."""
    if len(code7) != 7:
        return 0
    code6, check = code7[:6], code7[6:]
    if not check.isdigit():
        return 0
    cd = sedol_check_digit(code6)
    return 1 if cd != -1 and cd == int(check) else 0


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return

    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <SEDOL>")

    print(is_valid_sedol(argv[0].strip()))


def _run_tests() -> None:
    import unittest

    class TestChallenge135Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(is_valid_sedol("2936921"), 1)

        def test_example_2(self) -> None:
            self.assertEqual(is_valid_sedol("1234567"), 0)

        def test_example_3(self) -> None:
            self.assertEqual(is_valid_sedol("B0YBKL9"), 1)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge135Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

