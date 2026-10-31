#!/usr/bin/env python3
"""Relative Sort - The Weekly Challenge 284 Task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def relative_sort(list1: list[int], list2: list[int]) -> list[int]:
    """Sort the elements of list1 based on the relative order defined in list2.

    Elements not in list2 are placed at the end in ascending order.

    Args:
        list1: The list of integers to sort.
        list2: The list defining the relative order.

    Returns:
        The sorted list of integers.
    """
    order: dict[int, int] = {num: idx for idx, num in enumerate(list2)}
    in_list2: list[int] = []
    not_in_list2: list[int] = []

    for num in list1:
        if num in order:
            in_list2.append(num)
        else:
            not_in_list2.append(num)

    # Sort elements in list1 that are in list2 based on the order in list2
    in_list2.sort(key=lambda x: (order[x], x))

    # Sort elements not in list2 in ascending order
    not_in_list2.sort()

    return in_list2 + not_in_list2


class TestRelativeSort(unittest.TestCase):
    """Unit tests for relative_sort."""

    def test_example1(self) -> None:
        """Test Example 1."""
        list1 = [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5]
        list2 = [2, 1, 4, 3, 5, 6]
        expected = [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9]
        self.assertEqual(relative_sort(list1, list2), expected)

    def test_example2(self) -> None:
        """Test Example 2."""
        list1 = [3, 3, 4, 6, 2, 4, 2, 1, 3]
        list2 = [1, 3, 2]
        expected = [1, 3, 3, 3, 2, 2, 4, 4, 6]
        self.assertEqual(relative_sort(list1, list2), expected)

    def test_example3(self) -> None:
        """Test Example 3."""
        list1 = [3, 0, 5, 0, 2, 1, 4, 1, 1]
        list2 = [1, 0, 3, 2]
        expected = [1, 1, 1, 0, 0, 3, 2, 4, 5]
        self.assertEqual(relative_sort(list1, list2), expected)

    def test_additional(self) -> None:
        """Test additional case with trailing elements."""
        list1 = [7, 5, 9, 4, 8, 6]
        list2 = [5, 7, 6]
        expected = [5, 7, 6, 4, 8, 9]
        self.assertEqual(relative_sort(list1, list2), expected)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) == 3:
        l1 = [int(x) for x in argv[1].split()]
        l2 = [int(x) for x in argv[2].split()]
        res = relative_sort(l1, l2)
        print(f"Output: ({', '.join(str(x) for x in res)})")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
