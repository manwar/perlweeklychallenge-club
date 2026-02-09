#!/usr/bin/env python3
"""
Perl Weekly Challenge 104 - Task 2: NIM Game

Simulate the NIM game with:
  - 12 tokens initially
  - each player can take 1, 2, or 3 tokens
  - whoever takes the last token wins

This script provides an interactive mode (`play`) against a simple optimal
strategy machine.
"""

from __future__ import annotations

from typing import Optional, Sequence


def optimal_take(tokens: int) -> int:
    """
    Return the optimal take (1..3) for the current player, assuming perfect play,
    or 1 if no forced win exists (i.e., tokens is a multiple of 4).
    """
    if tokens <= 0:
        raise ValueError("tokens must be positive")
    take = tokens % 4
    return take if take != 0 else 1


def play_nim(tokens: int = 12) -> None:
    """Play interactively against the machine."""
    remaining = tokens
    while remaining > 0:
        while True:
            raw = input(f"Tokens remaining: {remaining}. How many do you take (1-3)? ").strip()
            if raw in {"1", "2", "3"}:
                take = int(raw)
                if take <= remaining:
                    break
            print("Invalid move, try again.")

        remaining -= take
        if remaining == 0:
            print("Great job! You have won!")
            return

        comp_take = min(optimal_take(remaining), remaining)
        print(f"Comp takes {comp_take}")
        remaining -= comp_take
        if remaining == 0:
            print("Sorry, comp won")
            return


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return

    if len(argv) == 1 and argv[0] == "play":
        play_nim()
        return

    raise SystemExit(f"Usage: {__file__} [play]")


def _run_tests() -> None:
    import unittest

    class TestChallenge104Task2(unittest.TestCase):
        def test_optimal_take_range(self) -> None:
            for t in range(1, 50):
                take = optimal_take(t)
                self.assertIn(take, (1, 2, 3))

        def test_optimal_take_leaves_multiple_of_4_when_possible(self) -> None:
            for t in range(1, 50):
                take = optimal_take(t)
                if t % 4 != 0:
                    self.assertEqual((t - take) % 4, 0)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge104Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

