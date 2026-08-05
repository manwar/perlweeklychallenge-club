#!/usr/bin/env python3
"""Outermost Parentheses - Perl Weekly Challenge 385 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def remove_outermost_parentheses(s: str) -> str:
    """Return the string after removing the outermost parentheses of primitive strings."""
    result = []
    depth = 0

    for char in s:
        if char == "(":
            if depth > 0:
                result.append(char)
            depth += 1
        elif char == ")":
            depth -= 1
            if depth > 0:
                result.append(char)

    return "".join(result)


class OutermostParenthesesExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(remove_outermost_parentheses("()()()"), "")

    def test_example_2(self) -> None:
        self.assertEqual(remove_outermost_parentheses("(((())))"), "((()))")

    def test_example_3(self) -> None:
        self.assertEqual(remove_outermost_parentheses("(()())(())"), "()()()")

    def test_example_4(self) -> None:
        self.assertEqual(remove_outermost_parentheses("()((()))()"), "(())")

    def test_example_5(self) -> None:
        self.assertEqual(remove_outermost_parentheses("(()(()))(()())"), "()(())()()")


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-2.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
