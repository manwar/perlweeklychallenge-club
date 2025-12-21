#!/usr/bin/env python3
"""Binary Prefix - Perl Weekly Challenge 352 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def binary_prefix_divisible_by_5(nums: Sequence[int]) -> list[bool]:
    """
    For each prefix of a 0/1 list, return whether the binary value is divisible by 5.

    Instead of building the integer value for each prefix, keep the remainder
    modulo 5: r = (r * 2 + bit) % 5.
    """
    remainder = 0
    answer: list[bool] = []

    for bit in nums:
        if bit not in (0, 1):
            raise ValueError("Expected only 0/1 values")
        remainder = (remainder * 2 + bit) % 5
        answer.append(remainder == 0)

    return answer


class BinaryPrefixExamples(unittest.TestCase):
    """Example-based tests from the challenge specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            binary_prefix_divisible_by_5((0, 1, 1, 0, 0, 1, 0, 1, 1, 1)),
            [True, False, False, False, False, True, True, False, False, False],
        )

    def test_example_2(self) -> None:
        self.assertEqual(
            binary_prefix_divisible_by_5((1, 0, 1, 0, 1, 0)),
            [False, False, True, True, False, False],
        )

    def test_example_3(self) -> None:
        self.assertEqual(
            binary_prefix_divisible_by_5((0, 0, 1, 0, 1)),
            [True, True, False, False, True],
        )

    def test_example_4(self) -> None:
        self.assertEqual(
            binary_prefix_divisible_by_5((1, 1, 1, 1, 1)),
            [False, False, False, True, False],
        )

    def test_example_5(self) -> None:
        self.assertEqual(
            binary_prefix_divisible_by_5((1, 0, 1, 1, 0, 1, 0, 0, 1, 1)),
            [False, False, True, False, False, True, True, True, False, False],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    nums = [int(value) for value in args]
    result = binary_prefix_divisible_by_5(nums)
    output = ", ".join("true" if value else "false" for value in result)
    print(f"Input:  @nums = ({','.join(args)})")
    print(f"Output: ({output})")


if __name__ == "__main__":
    main()
