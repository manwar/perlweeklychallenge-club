#!/usr/bin/env python3
"""
Task 2: Buddy Strings

Given two strings of equal length, determine whether swapping a single pair of
characters in the source string can produce the target string. Identical
strings are considered buddies when any character appears at least twice.
"""
from __future__ import annotations

import unittest


def are_buddy_strings(source: str, target: str) -> bool:
    """
    Decide whether `source` and `target` form a pair of buddy strings.

    Args:
        source: Original string.
        target: Desired string after at most one swap.

    Returns:
        True when a single swap (or a swap of identical characters) can make
        the strings equal, otherwise False.
    """
    if len(source) != len(target):
        return False

    if source == target:
        # Identical strings are buddies if any character repeats.
        return len(set(source)) < len(source)

    differences: list[tuple[str,
                            str]] = [(s_char, t_char)
                                     for s_char, t_char in zip(source, target)
                                     if s_char != t_char]

    if len(differences) != 2:
        return False

    (first_source, first_target), (second_source, second_target) = differences
    return first_source == second_target and first_target == second_source


class BuddyStringTests(unittest.TestCase):

    def test_example_1(self) -> None:
        self.assertTrue(are_buddy_strings("fuck", "fcuk"))

    def test_example_2(self) -> None:
        self.assertFalse(are_buddy_strings("love", "love"))

    def test_example_3(self) -> None:
        self.assertTrue(are_buddy_strings("fodo", "food"))

    def test_example_4(self) -> None:
        self.assertTrue(are_buddy_strings("feed", "feed"))


if __name__ == "__main__":
    unittest.main()
