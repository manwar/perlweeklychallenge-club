#!/usr/bin/env python3
"""
Perl Weekly Challenge 101 - Task 1: Pack a Spiral

Pack a list of items into an MxN matrix, spirally counterclockwise, as tightly
as possible (minimize abs(M-N) among factor pairs with M*N == len(items)).

This implementation follows the orientation used by the existing Perl solution:
the returned matrix is indexed from the bottom row upwards (row 0 is the
bottom), which matches the examples when printed with the top row first.
"""

from __future__ import annotations

from typing import List, Sequence, Tuple, TypeVar


T = TypeVar("T")


def _best_shape(size: int) -> Tuple[int, int]:
    """Return (cols, rows) such that cols*rows=size and abs(cols-rows) is minimal."""
    if size <= 0:
        raise ValueError("size must be positive")

    cols = int(size**0.5)
    while size % cols != 0:
        cols -= 1
    rows = size // cols
    return cols, rows


def pack_spiral(items: Sequence[T]) -> List[List[T]]:
    """Return a matrix (bottom row first) filled counterclockwise in a spiral."""
    if not items:
        return []

    cols, rows = _best_shape(len(items))
    out: List[List[T]] = [[None for _ in range(cols)] for _ in range(rows)]  # type: ignore[list-item]
    seen = [[False for _ in range(cols)] for _ in range(rows)]

    r, c = 0, 0
    direction = ">"

    idx = 0
    while idx < len(items):
        out[r][c] = items[idx]
        seen[r][c] = True
        idx += 1

        if idx == len(items):
            break

        if direction == ">":
            if c + 1 < cols and not seen[r][c + 1]:
                c += 1
            else:
                direction = "^"
                r += 1
        elif direction == "^":
            if r + 1 < rows and not seen[r + 1][c]:
                r += 1
            else:
                direction = "<"
                c -= 1
        elif direction == "<":
            if c - 1 >= 0 and not seen[r][c - 1]:
                c -= 1
            else:
                direction = "v"
                r -= 1
        else:  # "v"
            if r - 1 >= 0 and not seen[r - 1][c]:
                r -= 1
            else:
                direction = ">"
                c += 1

    return out


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit(f"Usage: {__file__}  # runs tests only")


def _run_tests() -> None:
    import unittest

    class TestChallenge101Task1(unittest.TestCase):
        def test_example_1(self) -> None:
            self.assertEqual(pack_spiral([1, 2, 3, 4]), [[1, 2], [4, 3]])

        def test_example_2(self) -> None:
            self.assertEqual(pack_spiral(list(range(1, 7))), [[1, 2], [6, 3], [5, 4]])

        def test_example_3(self) -> None:
            self.assertEqual(
                pack_spiral(list(range(1, 13))),
                [[1, 2, 3], [10, 11, 4], [9, 12, 5], [8, 7, 6]],
            )

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge101Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

