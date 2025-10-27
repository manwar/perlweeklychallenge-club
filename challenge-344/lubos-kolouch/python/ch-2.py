#!/usr/bin/env python3
"""
Perl Weekly Challenge: Task 2 - Array Formation
Check whether the target array can be formed by concatenating the source subarrays without reordering their elements.
"""

from __future__ import annotations

import unittest


def array_formation(source: list[list[int]], target: list[int]) -> bool:
    """
    Determine if ``target`` can be constructed by concatenating subarrays from ``source``.

    Args:
        source (list[list[int]]): Available subarrays that may be reordered but not restructured.
        target (list[int]): Desired array to build.

    Returns:
        bool: ``True`` if the target can be formed, otherwise ``False``.
    """
    used = [False] * len(source)
    index = 0

    while index < len(target):
        matched = False

        for i, piece in enumerate(source):
            if used[i] or not piece or piece[0] != target[index]:
                continue

            if index + len(piece) > len(target):
                continue

            if all(target[index + offset] == value
                   for offset, value in enumerate(piece)):
                used[i] = True
                index += len(piece)
                matched = True
                break

        if not matched:
            return False

    return True


class TestArrayFormation(unittest.TestCase):
    """Unit tests for the array_formation function."""

    def test_example_1(self) -> None:
        """Example 1: ([2,3], [1], [4]) -> (1, 2, 3, 4)"""
        source = [[2, 3], [1], [4]]
        target = [1, 2, 3, 4]
        self.assertTrue(array_formation(source, target))

    def test_example_2(self) -> None:
        """Example 2: ([1,3], [2,4]) -> (1, 2, 3, 4)"""
        source = [[1, 3], [2, 4]]
        target = [1, 2, 3, 4]
        self.assertFalse(array_formation(source, target))

    def test_example_3(self) -> None:
        """Example 3: ([9,1], [5,8], [2]) -> (5, 8, 2, 9, 1)"""
        source = [[9, 1], [5, 8], [2]]
        target = [5, 8, 2, 9, 1]
        self.assertTrue(array_formation(source, target))

    def test_example_4(self) -> None:
        """Example 4: ([1], [3]) -> (1, 2, 3)"""
        source = [[1], [3]]
        target = [1, 2, 3]
        self.assertFalse(array_formation(source, target))

    def test_example_5(self) -> None:
        """Example 5: ([7,4,6]) -> (7, 4, 6)"""
        source = [[7, 4, 6]]
        target = [7, 4, 6]
        self.assertTrue(array_formation(source, target))


if __name__ == "__main__":
    unittest.main()
