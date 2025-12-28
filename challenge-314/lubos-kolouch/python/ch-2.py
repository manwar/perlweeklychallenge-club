#!/usr/bin/env python3
"""Sort Column - Perl Weekly Challenge 314 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def sort_column_deleted(rows: Sequence[str]) -> int:
    """Return number of columns that must be deleted to make columns sorted."""
    if len(rows) <= 1:
        return 0
    length = len(rows[0])
    if any(len(row) != length for row in rows):
        raise ValueError("All strings must have the same length")

    deleted = 0
    for col in range(length):
        for r in range(1, len(rows)):
            if rows[r - 1][col] > rows[r][col]:
                deleted += 1
                break
    return deleted


class SortColumnExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(sort_column_deleted(("swpc", "tyad", "azbe")), 2)

    def test_example_2(self) -> None:
        self.assertEqual(sort_column_deleted(("cba", "daf", "ghi")), 1)

    def test_example_3(self) -> None:
        self.assertEqual(sort_column_deleted(("a", "b", "c")), 0)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    quoted = '", "'.join(args)
    print(f'Input:  @list = ("{quoted}")')
    print(f"Output: {sort_column_deleted(args)}")


if __name__ == "__main__":
    main()
