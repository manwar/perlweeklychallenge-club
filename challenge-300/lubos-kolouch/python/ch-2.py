#!/usr/bin/env python3
"""Nested Array - Perl Weekly Challenge 300 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def nested_array_max(ints: Sequence[int]) -> int:
    """Return the maximum length of set[i] sequences described in the task."""
    n = len(ints)
    if n == 0:
        return 0

    visited = [False] * n
    best = 0

    for start in range(n):
        if visited[start]:
            continue

        seen_in_walk: set[int] = set()
        current = start
        length = 0
        while not visited[current] and current not in seen_in_walk:
            seen_in_walk.add(current)
            length += 1
            current = ints[current]

        # mark component
        current = start
        while not visited[current]:
            visited[current] = True
            current = ints[current]

        if length > best:
            best = length

    return best


class NestedArrayExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(nested_array_max((5, 4, 0, 3, 1, 6, 2)), 4)

    def test_example_2(self) -> None:
        self.assertEqual(nested_array_max((0, 1, 2)), 1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    ints = [int(token) for token in args]
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: {nested_array_max(ints)}")


if __name__ == "__main__":
    main()
