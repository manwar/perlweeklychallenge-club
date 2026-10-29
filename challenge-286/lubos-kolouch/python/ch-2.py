#!/usr/bin/env python3
"""Order Game - The Weekly Challenge 286 Task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def order_game(ints: list[int]) -> int:
    """Simulate the Order Game on the given list of integers.

    In the Order Game:
    - At each round, the array is reduced by pairing consecutive elements.
    - For each pair at an even index (starting from 0), take the minimum of the pair.
    - For each pair at an odd index, take the maximum of the pair.
    - Repeat the process until only one element remains.

    Args:
        ints: A list of integers whose length is a power of 2.

    Returns:
        The last remaining integer after playing the game.
    """
    current_list = list(ints)
    while len(current_list) > 1:
        next_list: list[int] = []
        n = len(current_list)
        for i in range(n // 2):
            first = current_list[2 * i]
            second = current_list[2 * i + 1]
            if i % 2 == 0:
                next_list.append(min(first, second))
            else:
                next_list.append(max(first, second))
        current_list = next_list
    return current_list[0]


class TestOrderGame(unittest.TestCase):
    """Unit tests for order_game."""

    def test_example1(self) -> None:
        """Test Example 1: [2, 1, 4, 5, 6, 3, 0, 2] -> 1."""
        ints = [2, 1, 4, 5, 6, 3, 0, 2]
        self.assertEqual(order_game(ints), 1)

    def test_example2(self) -> None:
        """Test Example 2: [0, 5, 3, 2] -> 0."""
        ints = [0, 5, 3, 2]
        self.assertEqual(order_game(ints), 0)

    def test_example3(self) -> None:
        """Test Example 3: 16 integers -> 2."""
        ints = [9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]
        self.assertEqual(order_game(ints), 2)

    def test_power_of_two_length(self) -> None:
        """Test minimal pair of 2 integers."""
        ints = [7, 3]
        self.assertEqual(order_game(ints), 3)

    def test_monotonic(self) -> None:
        """Test list of 4 integers."""
        ints = [1, 2, 3, 4]
        # Round 1: i=0: min(1,2)=1, i=1: max(3,4)=4 -> [1, 4]
        # Round 2: i=0: min(1,4)=1 -> 1
        self.assertEqual(order_game(ints), 1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        nums = [int(x) for x in argv[1:]]
        print(f"Output: {order_game(nums)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
