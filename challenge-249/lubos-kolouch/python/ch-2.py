#!/usr/bin/env python3
"""DI String Match - Perl Weekly Challenge 249, Task 2."""

from __future__ import annotations

import unittest


def di_string_match(s: str) -> list[int]:
    """Return a permutation of [0 .. len(s)] matching 'I'/'D' constraints."""
    low, high = 0, len(s)
    perm: list[int] = []

    for char in s:
        if char == "I":
            perm.append(low)
            low += 1
        elif char == "D":
            perm.append(high)
            high -= 1
        else:
            raise ValueError(f"Invalid character {char!r}: expected 'I' or 'D'")

    perm.append(low)
    return perm


class TestDIStringMatch(unittest.TestCase):
    """Unit tests for the di_string_match function."""

    def test_examples(self) -> None:
        """Verify all challenge examples and edge cases."""
        cases: list[tuple[str, list[int]]] = [
            ("IDID", [0, 4, 1, 3, 2]),
            ("III", [0, 1, 2, 3]),
            ("DDI", [3, 2, 0, 1]),
            ("", [0]),
        ]
        for s, expected in cases:
            with self.subTest(s=s):
                self.assertEqual(di_string_match(s), expected)


if __name__ == "__main__":
    unittest.main()
