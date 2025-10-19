#!/usr/bin/env python3
"""
Perl Weekly Challenge: Task 2 - Champion Team
Find the team with the most wins, or the strongest among those with the most wins.
"""

import unittest


def champion_team(grid: list[list[int]]) -> str:
    """
    Find the champion team with the most wins, or the strongest among those tied.

    Args:
        grid (list[list[int]]): Matrix where grid[i][j] == 1 means team i beats team j,
                                grid[i][j] == 0 means team j beats team i.

    Returns:
        str: The champion team as "Team X" where X is the team index.
    """
    n = len(grid)
    if n == 0:
        return "Team -1"

    # Count wins for each team
    wins = [sum(grid[i][j] for j in range(n) if i != j) for i in range(n)]

    # Find maximum wins
    max_wins = max(wins)

    # Find teams with maximum wins
    top_teams = [i for i, win in enumerate(wins) if win == max_wins]

    # If only one team has max wins, return it
    if len(top_teams) == 1:
        return f"Team {top_teams[0]}"

    # Among top teams, find the one that beats others
    for i in top_teams:
        is_champion = True
        for j in top_teams:
            if i != j and not grid[i][j]:
                is_champion = False
                break
        if is_champion:
            return f"Team {i}"

    # Fallback (should not occur given problem constraints)
    return f"Team {top_teams[0]}"


# Unit tests


class TestChampionTeam(unittest.TestCase):
    """Unit tests for the champion_team function."""

    def test_case_1(self):
        """Test Case 1: 3x3 grid -> Team 0"""
        grid = [[0, 1, 1], [0, 0, 1], [0, 0, 0]]
        self.assertEqual(champion_team(grid), 'Team 0')

    def test_case_2(self):
        """Test Case 2: 4x4 grid -> Team 3"""
        grid = [[0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 0, 0], [1, 1, 1, 0]]
        self.assertEqual(champion_team(grid), 'Team 3')

    def test_case_3(self):
        """Test Case 3: 4x4 grid -> Team 0"""
        grid = [[0, 1, 0, 1], [0, 0, 1, 1], [1, 0, 0, 0], [0, 0, 1, 0]]
        self.assertEqual(champion_team(grid), 'Team 0')

    def test_case_4(self):
        """Test Case 4: 3x3 grid -> Team 0"""
        grid = [[0, 1, 1], [0, 0, 0], [0, 1, 0]]
        self.assertEqual(champion_team(grid), 'Team 0')

    def test_case_5(self):
        """Test Case 5: 5x5 grid -> Team 2"""
        grid = [[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 1, 0, 1, 1],
                [1, 1, 0, 0, 0], [1, 1, 0, 1, 0]]
        self.assertEqual(champion_team(grid), 'Team 2')


if __name__ == '__main__':
    unittest.main()
