#!/usr/bin/env python3
"""Three Power - Perl Weekly Challenge 254, Task 1."""

from __future__ import annotations

import unittest


def is_power_of_three(n: int) -> bool:
    """Return True if n is a power of three (or 0 = 0^3), False otherwise."""
    if n == 0:
        return True
    if n < 1:
        return False

    while n % 3 == 0:
        n //= 3

    return n == 1


class TestThreePower(unittest.TestCase):
    """Unit tests for the is_power_of_three function."""

    def test_examples(self) -> None:
        """Verify all challenge examples and edge cases."""
        cases: list[tuple[int, bool]] = [
            (27, True),
            (0, True),
            (6, False),
            (1, True),
            (81, True),
            (-3, False),
        ]
        for value, expected in cases:
            with self.subTest(value=value):
                self.assertEqual(is_power_of_three(value), expected)


if __name__ == "__main__":
    unittest.main()
