#!/usr/bin/env python3
"""Alternate Case - Perl Weekly Challenge 394 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def min_swaps_to_alternate(s: str) -> int:
    """Calculate minimum adjacent swaps to turn string into alternating case."""
    if len(s) <= 1:
        return 0

    upper_pos: list[int] = []
    lower_pos: list[int] = []

    for idx, char in enumerate(s):
        if char.isupper():
            upper_pos.append(idx)
        elif char.islower():
            lower_pos.append(idx)
        else:
            raise ValueError(f"String must contain only English letters: {char}")

    if len(upper_pos) != len(lower_pos):
        raise ValueError(
            "String must contain equal number of uppercase and lowercase letters"
        )

    # Pattern A: Upper at even indices (0, 2, 4...), Lower at odd (1, 3, 5...)
    swaps_upper_first = sum(abs(pos - 2 * k) for k, pos in enumerate(upper_pos))

    # Pattern B: Lower at even indices (0, 2, 4...), Upper at odd (1, 3, 5...)
    swaps_lower_first = sum(abs(pos - 2 * k) for k, pos in enumerate(lower_pos))

    return min(swaps_upper_first, swaps_lower_first)


class TestAlternateCase(unittest.TestCase):
    """Unit tests for min_swaps_to_alternate."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(min_swaps_to_alternate("aAbB"), 0)

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(min_swaps_to_alternate("AAbb"), 1)

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(min_swaps_to_alternate("AAAbbb"), 3)

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(min_swaps_to_alternate("aABb"), 1)

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(min_swaps_to_alternate("bBBAaa"), 2)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        print(f"Output: {min_swaps_to_alternate(argv[1])}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
