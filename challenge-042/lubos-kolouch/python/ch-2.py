#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest
import random


def generate_bracket_string(length: int) -> str:
    """Generates a random string of ( and ) brackets of the specified length.

    Args:
        length: The length of the bracket string to generate.

    Returns:
        The generated bracket string.
    """
    brackets = ["(", ")"]
    return "".join(random.choices(brackets, k=length))


def is_balanced(bracket_string: str) -> bool:
    """Checks if a string has balanced brackets.

    Args:
        bracket_string: The string to check.

    Returns:
        True if the string has balanced brackets, False otherwise.
    """
    stack = []
    for bracket in bracket_string:
        if bracket == "(":
            stack.append(bracket)
        elif bracket == ")":
            if len(stack) == 0:
                return False
            stack.pop()
    return len(stack) == 0


class TestIsBalanced(unittest.TestCase):
    def test_empty_string(self) -> None:
        self.assertTrue(is_balanced(""))

    def test_single_opening_bracket(self) -> None:
        self.assertFalse(is_balanced("("))

    def test_single_closing_bracket(self) -> None:
        self.assertFalse(is_balanced(")"))

    def test_balanced_string(self) -> None:
        self.assertTrue(is_balanced("(())()"))

    def test_unbalanced_string(self) -> None:
        self.assertFalse(is_balanced("(()))"))


if __name__ == "__main__":
    unittest.main()

bracket_string = generate_bracket_string(10)
print(f"Bracket string: {bracket_string}")
if is_balanced(bracket_string):
    print("The bracket string is balanced")
else:
    print("The bracket string is not balanced")
