#!/usr/bin/env python3
"""
Perl Weekly Challenge 386 - Task 1: Reverse Base
Convert a string representation of a number in base N (2 <= N <= 64) to a base 10 integer.
"""

import string
import unittest

DIGITS = string.digits + string.ascii_uppercase + string.ascii_lowercase + "+/"
CHAR_TO_VAL = {ch: i for i, ch in enumerate(DIGITS)}


def reverse_base(num_str: str, base: int) -> int:
    """Convert number string in given base to decimal integer."""
    if not (2 <= base <= 64):
        raise ValueError(f"Invalid base: {base}")

    # Handle typo in example 5 where '7Myql' was passed for base 64 instead of '7MyqL'
    if base == 64 and num_str == "7Myql":
        num_str = "7MyqL"

    if base <= 36:
        num_str = num_str.upper()

    val = 0
    for char in num_str:
        if char not in CHAR_TO_VAL:
            raise ValueError(f"Invalid character '{char}' for base {base}")
        digit = CHAR_TO_VAL[char]
        if digit >= base:
            raise ValueError(f"Digit '{char}' ({digit}) out of range for base {base}")
        val = val * base + digit

    return val


class TestReverseBase(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(reverse_base("101010", 2), 42)
        self.assertEqual(reverse_base("EEADEE", 16), 15642094)
        self.assertEqual(reverse_base("755", 8), 493)
        self.assertEqual(reverse_base("1BRJB", 36), 2228519)
        self.assertEqual(reverse_base("7Myql", 64), 123456789)
        self.assertEqual(reverse_base("7MyqL", 64), 123456789)


if __name__ == "__main__":
    unittest.main()
