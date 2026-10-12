#!/usr/bin/env python3
"""Zuma Game - Perl Weekly Challenge 292 task 2."""

from __future__ import annotations

from collections import deque
from collections.abc import Sequence
import re
import sys
import unittest


def eliminate(board: str) -> str:
    """Eliminate consecutive groups of three or more identical balls from the board."""
    pattern = re.compile(r"(.)\1{2,}")
    changed = True
    while changed:
        board, num_subs = pattern.subn("", board)
        changed = num_subs > 0
    return board


def find_min_steps(board: str, hand: str) -> int:
    """Find minimum number of balls to insert from hand to clear board, or -1."""
    hand_counts: dict[str, int] = {}
    for c in hand:
        hand_counts[c] = hand_counts.get(c, 0) + 1

    queue: deque[tuple[str, dict[str, int], int]] = deque()
    queue.append((board, hand_counts.copy(), 0))

    visited: set[tuple[str, tuple[tuple[str, int], ...]]] = set()

    while queue:
        current_board, current_hand, steps = queue.popleft()

        if not current_board:
            return steps

        hand_key = tuple(sorted(current_hand.items()))
        state_key = (current_board, hand_key)

        if state_key in visited:
            continue
        visited.add(state_key)

        for i in range(len(current_board) + 1):
            for color in sorted(current_hand.keys()):
                if current_hand[color] <= 0:
                    continue

                new_board = current_board[:i] + color + current_board[i:]
                new_board = eliminate(new_board)

                new_hand = current_hand.copy()
                new_hand[color] -= 1
                if new_hand[color] == 0:
                    del new_hand[color]

                new_hand_key = tuple(sorted(new_hand.items()))
                new_state_key = (new_board, new_hand_key)

                if new_state_key in visited:
                    continue

                queue.append((new_board, new_hand, steps + 1))

    return -1


class TestZumaGame(unittest.TestCase):
    """Unit tests for find_min_steps."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(find_min_steps("WRRBBW", "RB"), -1)

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(find_min_steps("WWRRBBWW", "WRBRW"), 2)

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(find_min_steps("G", "GGGGG"), 2)

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(find_min_steps("RBYYBBRRB", "YRBGB"), 3)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) == 3:
        print(f"Output: {find_min_steps(argv[1], argv[2])}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
