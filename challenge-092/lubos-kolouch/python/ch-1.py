#!/usr/bin/env python3
"""
Perl Weekly Challenge 092 - Task 1: Isomorphic Strings

Given two strings A and B of equal length, determine if they are isomorphic.

Two strings are isomorphic if characters in A can be replaced to get B with a
one-to-one mapping (no two characters in A map to the same character in B).
"""

from __future__ import annotations

from typing import Dict, Sequence


def is_isomorphic(a: str, b: str) -> int:
    """Return 1 if `a` and `b` are isomorphic, else 0."""
    if len(a) != len(b):
        return 0

    a_to_b: Dict[str, str] = {}
    b_to_a: Dict[str, str] = {}

    for ca, cb in zip(a, b):
        if ca in a_to_b and a_to_b[ca] != cb:
            return 0
        if cb in b_to_a and b_to_a[cb] != ca:
            return 0
        a_to_b[ca] = cb
        b_to_a[cb] = ca

    return 1


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <A> <B>")
    print(is_isomorphic(argv[0], argv[1]))


def _run_tests() -> None:
    import unittest

    class TestChallenge092Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(is_isomorphic("abc", "xyz"), 1)

        def test_example_2(self) -> None:
            self.assertEqual(is_isomorphic("abb", "xyy"), 1)

        def test_example_3(self) -> None:
            self.assertEqual(is_isomorphic("sum", "add"), 0)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge092Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

