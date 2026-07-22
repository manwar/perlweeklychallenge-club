#!/usr/bin/env python3
"""Similar List - Perl Weekly Challenge 383 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def are_similar_lists(
    list1: list[str], list2: list[str], list3: list[list[str]]
) -> bool:
    """Return True if list1 and list2 are similar according to list3 map."""
    if len(list1) != len(list2):
        return False

    for w1, w2 in zip(list1, list2):
        if w1 == w2:
            continue

        # Check if there is any list in list3 containing both w1 and w2
        found = False
        for map_list in list3:
            map_set = set(map_list)
            if w1 in map_set and w2 in map_set:
                found = True
                break
        if not found:
            return False

    return True


class SimilarListExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertTrue(
            are_similar_lists(
                ["great", "acting"],
                ["fine", "drama"],
                [["great", "fine"], ["acting", "drama"]],
            )
        )

    def test_example_2(self) -> None:
        self.assertFalse(
            are_similar_lists(
                ["apple", "pie"],
                ["banana", "pie"],
                [["apple", "peach"], ["peach", "banana"]],
            )
        )

    def test_example_3(self) -> None:
        self.assertTrue(
            are_similar_lists(
                ["perl4", "python"],
                ["raku", "python"],
                [["perl4", "perl5", "raku"]],
            )
        )

    def test_example_4(self) -> None:
        self.assertFalse(
            are_similar_lists(
                ["enjoy", "challenge"],
                ["love", "weekly", "challenge"],
                [["enjoy", "love"]],
            )
        )

    def test_example_5(self) -> None:
        self.assertTrue(
            are_similar_lists(
                ["fast", "car"],
                ["quick", "vehicle"],
                [["quick", "fast"], ["vehicle", "car"]],
            )
        )


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-1.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
