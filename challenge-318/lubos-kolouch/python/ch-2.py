#!/usr/bin/env python3
"""Reverse Equals - Perl Weekly Challenge 318 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def reverse_equals(source: Sequence[int], target: Sequence[int]) -> bool:
    """
    Return True if source can be made equal to target by reversing one subarray.

    If source already equals target, reversing a 1-element subarray keeps it
    equal, so the answer is True.
    """
    if len(source) != len(target):
        raise ValueError("Arrays must have the same length")
    if list(source) == list(target):
        return True

    left = 0
    while left < len(source) and source[left] == target[left]:
        left += 1

    right = len(source) - 1
    while right >= 0 and source[right] == target[right]:
        right -= 1

    candidate = list(source)
    candidate[left : right + 1] = reversed(candidate[left : right + 1])
    return candidate == list(target)


class ReverseEqualsExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertTrue(reverse_equals((3, 2, 1, 4), (1, 2, 3, 4)))

    def test_example_2(self) -> None:
        self.assertFalse(reverse_equals((1, 3, 4), (4, 1, 3)))

    def test_example_3(self) -> None:
        self.assertTrue(reverse_equals((2,), (2,)))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 2:
        raise SystemExit(
            "Usage: python3 ch-2.py <comma-separated-source> <comma-separated-target>"
        )

    source = [int(value) for value in args[0].split(",") if value]
    target = [int(value) for value in args[1].split(",") if value]
    result = "true" if reverse_equals(source, target) else "false"
    print(f"Input: @source = ({', '.join(map(str, source))})")
    print(f"       @target = ({', '.join(map(str, target))})")
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
