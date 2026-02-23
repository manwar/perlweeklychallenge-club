#!/usr/bin/env python3
"""
Perl Weekly Challenge 362 - Task 1: Echo Chamber

Given a lowercase string, repeat each character according to its index position:
index 0 once, index 1 twice, index 2 three times, etc.
"""

from __future__ import annotations

from typing import Sequence


def echo_chamber(text: str) -> str:
    """Return the transformed string for Task 1."""
    return "".join(ch * (idx + 1) for idx, ch in enumerate(text))


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <lowercase-string>")
    print(echo_chamber(argv[0]))


def _run_tests() -> None:
    import unittest

    class TestChallenge362Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(echo_chamber("abca"), "abbcccaaaa")

        def test_example_2(self) -> None:
            self.assertEqual(echo_chamber("xyz"), "xyyzzz")

        def test_example_3(self) -> None:
            self.assertEqual(echo_chamber("code"), "coodddeeee")

        def test_example_4(self) -> None:
            self.assertEqual(echo_chamber("hello"), "heelllllllooooo")

        def test_example_5(self) -> None:
            self.assertEqual(echo_chamber("a"), "a")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge362Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
