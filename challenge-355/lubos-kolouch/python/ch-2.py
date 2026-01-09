#!/usr/bin/env python3
"""Mountain Array - Perl Weekly Challenge 355 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def is_mountain_array(ints: Sequence[int]) -> bool:
    """Return True if ints forms a valid mountain array."""
    n = len(ints)
    if n < 3:
        return False

    i = 1
    while i < n and ints[i - 1] < ints[i]:
        i += 1
    if i == 1 or i == n:
        return False

    while i < n and ints[i - 1] > ints[i]:
        i += 1
    return i == n


class MountainArrayExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertFalse(is_mountain_array((1, 2, 3, 4, 5)))

    def test_example_2(self) -> None:
        self.assertTrue(is_mountain_array((0, 2, 4, 6, 4, 2, 0)))

    def test_example_3(self) -> None:
        self.assertFalse(is_mountain_array((5, 4, 3, 2, 1)))

    def test_example_4(self) -> None:
        self.assertFalse(is_mountain_array((1, 3, 5, 5, 4, 2)))

    def test_example_5(self) -> None:
        self.assertTrue(is_mountain_array((1, 3, 2)))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    ints = [int(token) for token in args]
    print(f"Input:  @ints = ({', '.join(str(x) for x in ints)})")
    print(f"Output: {'true' if is_mountain_array(ints) else 'false'}")


if __name__ == "__main__":
    main()

