#!/usr/bin/env python3
"""Who Wins - Perl Weekly Challenge 356 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def who_wins(results: str) -> tuple[int, int, int]:
    """Return (home_team, away_team, winner_team) for the conference final."""
    if len(results) != 6 or any(ch not in "HA" for ch in results):
        raise ValueError("Expected a 6-character string of H/A")
    r = list(results)

    # Week 1 (wild card)
    w1 = 2 if r[0] == "H" else 7
    w2 = 3 if r[1] == "H" else 6
    w3 = 4 if r[2] == "H" else 5
    winners = sorted((w1, w2, w3))

    # Week 2 game 4: Team 1 hosts the third seeded winner (highest number)
    t4_away = winners[2]
    w4 = 1 if r[3] == "H" else t4_away

    # Week 2 game 5: highest seeded winner hosts the second seeded winner
    host5, away5 = sorted((winners[0], winners[1]))  # smallest hosts
    w5 = host5 if r[4] == "H" else away5

    # Week 3: highest seeded winner hosts the other winner
    host6, away6 = sorted((w4, w5))
    w6 = host6 if r[5] == "H" else away6

    return host6, away6, w6


class WhoWinsExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def _format(self, results: str) -> str:
        host, away, winner = who_wins(results)
        loser = away if winner == host else host
        return f"Team {winner} defeated Team {loser}"

    def test_example_1(self) -> None:
        self.assertEqual(self._format("HAHAHH"), "Team 2 defeated Team 6")

    def test_example_2(self) -> None:
        self.assertEqual(self._format("HHHHHH"), "Team 1 defeated Team 2")

    def test_example_3(self) -> None:
        self.assertEqual(self._format("HHHAHA"), "Team 4 defeated Team 2")

    def test_example_4(self) -> None:
        self.assertEqual(self._format("HAHAAH"), "Team 4 defeated Team 6")

    def test_example_5(self) -> None:
        self.assertEqual(self._format("HAAHAA"), "Team 5 defeated Team 1")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <results>")
    results = args[0]
    host, away, winner = who_wins(results)
    loser = away if winner == host else host
    print(f"Team {winner} defeated Team {loser}")


if __name__ == "__main__":
    main()

