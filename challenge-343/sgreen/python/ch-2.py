#!/usr/bin/env python3

import json
import re
import sys


def champion_team(matrix: list[list[int]], consider_teams: list[int]|None = None) -> str:
    """
    Determine the champion team from a results matrix.

    Input: A square matrix of 0s and 1s representing the strengths of teams.

    Returns: The champion team as a string, or "No champion" if there is a tie.
    """
    # Check the matrix is a square
    size = len(matrix)
    if any(len(row) != size for row in matrix):
        raise ValueError("Matrix must be square")

    # Check the matrix only contains only 0s and 1s
    if any(matrix[i][j] not in (0, 1) for i in range(size) for j in range(size)):
        raise ValueError("Matrix must only contain 0s and 1s")

    # Check a team does not win against itself
    if any(matrix[i][i] != 0 for i in range(size)):
        raise ValueError("A team cannot win against itself")

    # Consider all teams by default
    if consider_teams is None:
        consider_teams = list(range(len(matrix)))

    max_wins = -1
    winning_teams = []

    for team_index, results in enumerate(matrix):
        # Skip teams we don't need to look at
        if team_index not in consider_teams:
            continue

        # Find the wins for this team against other teams being considered
        wins = sum(results[i] for i in consider_teams)

        # If it is the best so far, update our records
        if wins > max_wins:
            max_wins = wins
            winning_teams = [team_index]
        elif wins == max_wins:
            winning_teams.append(team_index)

    if len(winning_teams) == 1:
        # We have one winner
        return f"Team {winning_teams[0]}"

    if len(winning_teams) == len(consider_teams):
        # There is a tie between two or more teams
        return "No champion"

    # Call the function recursively to break the tie
    return champion_team(matrix, consider_teams=winning_teams)


def main():
    # Convert input into a list of lists
    matrix = json.loads(sys.argv[1])
    result = champion_team(matrix)
    print(result)


if __name__ == '__main__':
    main()
