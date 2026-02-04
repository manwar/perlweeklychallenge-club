#!/usr/bin/env python3
"""
Perl Weekly Challenge 359 - Task 2: String Reduction

Repeatedly remove adjacent duplicate characters from a word (letters only)
until no adjacent duplicates remain, and return the final word.
"""

from __future__ import annotations

from typing import List, Sequence


def reduce_string(word: str) -> str:
    """Reduce by removing adjacent duplicates (stack-based)."""
    stack: List[str] = []
    for ch in word:
        if stack and stack[-1] == ch:
            stack.pop()
        else:
            stack.append(ch)
    return "".join(stack)


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <word>")
    print(reduce_string(argv[0]))


def _run_tests() -> None:
    import unittest

    class TestChallenge359Task2(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(reduce_string("aabbccdd"), "")

        def test_example_2(self) -> None:
            self.assertEqual(reduce_string("abccba"), "")

        def test_example_3(self) -> None:
            self.assertEqual(reduce_string("abcdef"), "abcdef")

        def test_example_4(self) -> None:
            self.assertEqual(reduce_string("aabbaeaccdd"), "aea")

        def test_example_5(self) -> None:
            self.assertEqual(reduce_string("mississippi"), "m")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge359Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

