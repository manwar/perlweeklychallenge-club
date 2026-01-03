#!/usr/bin/env python3
"""Special Quadruplets - Perl Weekly Challenge 203 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def special_quadruplets(nums: Sequence[int]) -> int:
    """Count quadruplets a<b<c<d where nums[a]+nums[b]+nums[c] == nums[d]."""
    n = len(nums)
    if n < 4:
        return 0

    pair_counts: dict[int, int] = {}
    total = 0

    for c in range(2, n - 1):
        b = c - 1
        for a in range(0, b):
            s = nums[a] + nums[b]
            pair_counts[s] = pair_counts.get(s, 0) + 1

        for d in range(c + 1, n):
            need = nums[d] - nums[c]
            total += pair_counts.get(need, 0)

    return total


class SpecialQuadrupletsExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(special_quadruplets((1, 2, 3, 6)), 1)

    def test_example_2(self) -> None:
        self.assertEqual(special_quadruplets((1, 1, 1, 3, 5)), 4)

    def test_example_3(self) -> None:
        self.assertEqual(special_quadruplets((3, 3, 6, 4, 5)), 0)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    nums = [int(token) for token in args]
    print(f"Input:  @nums = ({', '.join(str(x) for x in nums)})")
    print(f"Output: {special_quadruplets(nums)}")


if __name__ == "__main__":
    main()

