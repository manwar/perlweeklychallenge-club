#!/usr/bin/env python3
"""Strong Password - The Weekly Challenge 287 Task 1."""

from __future__ import annotations

from collections.abc import Sequence
import re
import sys
import unittest


def strong_password_steps(s: str) -> int:
    """Calculate the minimum steps to make the password strong.

    A strong password must:
    - Be at least 6 characters long.
    - Contain at least one lowercase letter, one uppercase letter, and one digit.
    - Not contain three repeating characters in a row.

    Args:
        s: The input password string.

    Returns:
        The minimum number of steps required to make the password strong.
    """
    missing_types = 3
    if re.search(r"[a-z]", s):
        missing_types -= 1
    if re.search(r"[A-Z]", s):
        missing_types -= 1
    if re.search(r"\d", s):
        missing_types -= 1

    repeats_to_fix = 0
    i = 2
    n = len(s)
    while i < n:
        if s[i] == s[i - 1] == s[i - 2]:
            repeat_len = 3
            while i + 1 < n and s[i + 1] == s[i]:
                repeat_len += 1
                i += 1
            repeats_to_fix += repeat_len // 3
        i += 1

    if n >= 6:
        total_steps = max(missing_types, repeats_to_fix)
    else:
        total_steps = max(missing_types + repeats_to_fix, 6 - n)
    return total_steps


class TestStrongPassword(unittest.TestCase):
    """Unit tests for strong_password_steps."""

    def test_example1(self) -> None:
        """Test Example 1: 'a' requires 5 steps."""
        self.assertEqual(strong_password_steps("a"), 5)

    def test_example2(self) -> None:
        """Test Example 2: 'aB2' requires 3 steps."""
        self.assertEqual(strong_password_steps("aB2"), 3)

    def test_example3(self) -> None:
        """Test Example 3: 'PaaSW0rd' is already strong (0 steps)."""
        self.assertEqual(strong_password_steps("PaaSW0rd"), 0)

    def test_example4(self) -> None:
        """Test Example 4: 'Paaasw0rd' requires 1 step."""
        self.assertEqual(strong_password_steps("Paaasw0rd"), 1)

    def test_example5(self) -> None:
        """Test Example 5: 'aaaaa' requires 3 steps."""
        self.assertEqual(strong_password_steps("aaaaa"), 3)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        print(f"Output: {strong_password_steps(argv[1])}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
