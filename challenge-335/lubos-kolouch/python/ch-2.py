#!/usr/bin/env python3
"""The Weekly Challenge 335 Task 2: Find Winner."""
import unittest

MoveList = list[list[int]]


def find_winner(moves: MoveList) -> str:
    """Return the tic-tac-toe game outcome for the given move sequence."""
    board = [["_" for _ in range(3)] for _ in range(3)]
    players = ["A", "B"]

    for index, (row, col) in enumerate(moves):
        board[row][col] = players[index % 2]

    winner = _check_winner(board)
    if winner:
        return winner
    return "Draw" if len(moves) == 9 else "Pending"


def _check_winner(board: list[list[str]]) -> str:
    lines = []
    lines.extend(board)
    lines.extend([[board[r][c] for r in range(3)] for c in range(3)])
    lines.append([board[i][i] for i in range(3)])
    lines.append([board[i][2 - i] for i in range(3)])

    for line in lines:
        if line[0] != "_" and line.count(line[0]) == 3:
            return line[0]
    return ""


class TestFindWinner(unittest.TestCase):
    """Unit tests derived from the challenge examples."""

    def test_example1(self) -> None:
        moves = [[0, 0], [2, 0], [1, 1], [2, 1], [2, 2]]
        self.assertEqual(find_winner(moves), "A")

    def test_example2(self) -> None:
        moves = [[0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0]]
        self.assertEqual(find_winner(moves), "B")

    def test_example3(self) -> None:
        moves = [[0, 0], [1, 1], [2, 0], [1, 0], [1, 2], [2, 1], [0, 1],
                 [0, 2], [2, 2]]
        self.assertEqual(find_winner(moves), "Draw")

    def test_example4(self) -> None:
        moves = [[0, 0], [1, 1]]
        self.assertEqual(find_winner(moves), "Pending")

    def test_example5(self) -> None:
        moves = [[1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2]]
        self.assertEqual(find_winner(moves), "B")


if __name__ == "__main__":
    unittest.main()
