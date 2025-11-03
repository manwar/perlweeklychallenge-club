"""Longest Parenthesis Challenge Solution.

Determine the length of the longest valid parenthesis substring within an
input consisting solely of opening and closing parentheses.
"""

from __future__ import annotations

import unittest


def longest_parenthesis(paren_string: str) -> int:
    """Return the length of the longest well-formed parenthesis substring.

    The algorithm scans the string once while maintaining a stack of indices
    for unmatched opening parentheses. A sentinel index of ``-1`` simplifies
    length calculations when a balanced substring is identified.
    """
    stack: list[int] = [-1]
    longest = 0

    for index, char in enumerate(paren_string):
        if char not in ("(", ")"):
            msg = "Input must contain only '(' and ')'."
            raise ValueError(msg)

        if char == "(":
            stack.append(index)
            continue

        stack.pop()
        if stack:
            candidate = index - stack[-1]
            longest = max(longest, candidate)
        else:
            stack.append(index)

    return longest


class LongestParenthesisTests(unittest.TestCase):
    """Unit tests restricted to the specification examples."""

    def test_example_1(self) -> None:
        self.assertEqual(longest_parenthesis("(()())"), 6)

    def test_example_2(self) -> None:
        self.assertEqual(longest_parenthesis(")()())"), 4)

    def test_example_3(self) -> None:
        self.assertEqual(longest_parenthesis("((()))()(((()"), 8)

    def test_example_4(self) -> None:
        self.assertEqual(longest_parenthesis("))))((()("), 2)

    def test_example_5(self) -> None:
        self.assertEqual(longest_parenthesis("()(()"), 2)


if __name__ == "__main__":
    unittest.main()
