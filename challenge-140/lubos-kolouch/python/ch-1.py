#!/usr/bin/env python3
"""
Perl Weekly Challenge 140 - Task 1: Add Binary

You are given two decimal-coded binary numbers, a and b. Simulate the addition
of the given binary numbers.
"""

from __future__ import annotations

from typing import Sequence


def add_binary(a: str, b: str) -> str:
    """Add two base-2 numbers given as strings and return the result as a string."""
    if not a or not b:
        raise ValueError("Inputs must be non-empty")
    if set(a) - {"0", "1"} or set(b) - {"0", "1"}:
        raise ValueError("Inputs must be binary strings containing only 0/1")

    carry = 0
    out: list[str] = []

    ia = len(a) - 1
    ib = len(b) - 1
    while ia >= 0 or ib >= 0 or carry:
        da = int(a[ia]) if ia >= 0 else 0
        db = int(b[ib]) if ib >= 0 else 0
        s = da + db + carry
        out.append(str(s & 1))
        carry = 1 if s >= 2 else 0
        ia -= 1
        ib -= 1

    return "".join(reversed(out))


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return

    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <a> <b>")

    print(add_binary(argv[0], argv[1]))


def _run_tests() -> None:
    import unittest

    class TestChallenge140Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(add_binary("11", "1"), "100")

        def test_example_2(self) -> None:
            self.assertEqual(add_binary("101", "1"), "110")

        def test_example_3(self) -> None:
            self.assertEqual(add_binary("100", "11"), "111")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge140Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

