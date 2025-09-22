#!/usr/bin/env python3
"""Solutions for The Weekly Challenge 340, Task 1 (Duplicate Removals).

The task asks for repeatedly deleting adjacent identical characters from a
lowercase string until no such pair remains. This implementation exposes the
core routine for reuse and embeds unit tests based solely on the official
examples.
"""

from __future__ import annotations

import unittest


def duplicate_removals(text: str) -> str:
    """Return the fully reduced form of *text* after removing adjacent duplicates.

    The algorithm processes the characters left to right while maintaining a
    stack (implemented as a Python list). A character equal to the current stack
    top cancels out the pair; otherwise the character is added to the stack. The
    final stack contents yield the reduced string.
    """

    stack: list[str] = []
    for char in text:
        if stack and stack[-1] == char:
            stack.pop()
        else:
            stack.append(char)
    return "".join(stack)


class DuplicateRemovalsTests(unittest.TestCase):
    """Exercises the routine against the provided examples."""

    def test_example_1(self) -> None:
        self.assertEqual(duplicate_removals("abbaca"), "ca")

    def test_example_2(self) -> None:
        self.assertEqual(duplicate_removals("azxxzy"), "ay")

    def test_example_3(self) -> None:
        self.assertEqual(duplicate_removals("aaaaaaaa"), "")

    def test_example_4(self) -> None:
        self.assertEqual(duplicate_removals("aabccba"), "a")

    def test_example_5(self) -> None:
        self.assertEqual(duplicate_removals("abcddcba"), "")


if __name__ == "__main__":
    unittest.main()
