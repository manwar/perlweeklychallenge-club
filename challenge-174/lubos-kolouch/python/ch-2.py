#!/usr/bin/env python3
"""Permutation Ranking - Perl Weekly Challenge 174 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import math
import sys
import unittest


def permutation2rank(perm: Sequence[int]) -> int:
    """Return 0-based lexicographic rank of the permutation."""
    avail = sorted(perm)
    n = len(avail)
    rank = 0
    for i, x in enumerate(perm):
        idx = avail.index(x)
        rank += idx * math.factorial(n - 1 - i)
        del avail[idx]
    return rank


def rank2permutation(alphabet: Sequence[int], rank: int) -> list[int]:
    """Return permutation at rank for given alphabet."""
    avail = sorted(alphabet)
    n = len(avail)
    max_rank = math.factorial(n) - 1
    if rank < 0 or rank > max_rank:
        raise ValueError("Rank out of range")

    out: list[int] = []
    r = rank
    for k in range(n, 0, -1):
        f = math.factorial(k - 1)
        idx, r = divmod(r, f)
        out.append(avail.pop(idx))
    return out


class PermutationRankingExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_rank(self) -> None:
        self.assertEqual(permutation2rank((1, 0, 2)), 2)

    def test_example_perm(self) -> None:
        self.assertEqual(rank2permutation((0, 1, 2), 1), [0, 2, 1])


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    perm = [int(token) for token in args]
    print(f"Input:  {perm}")
    print(f"Output: {permutation2rank(perm)}")


if __name__ == "__main__":
    main()

