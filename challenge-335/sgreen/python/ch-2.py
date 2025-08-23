#!/usr/bin/env python3

import sys


def check_winner(board: list[list[str]]) -> str | None:
    """
    Check the current state of the Tic Tac Toe board for a winner.

    Args:
        board (list[list[str]]): The current state of the Tic Tac Toe board

    Returns:
        str | None: 'A' if player A wins, 'B' if player B wins, or None if no winner yet
    """
    # Check rows and columns
    for i in range(3):
        if board[i][0] == board[i][1] == board[i][2] != '_':
            return board[i][0]
        if board[0][i] == board[1][i] == board[2][i] != '_':
            return board[0][i]

    # Check diagonals
    if board[0][0] == board[1][1] == board[2][2] != '_':
        return board[0][0]
    if board[0][2] == board[1][1] == board[2][0] != '_':
        return board[0][2]

    return None


def find_winner(moves: list[list[int]]) -> str:
    # Initialize the board
    board = [['_' for _ in range(3)] for _ in range(3)]

    # Player A starts first
    current_player = 'A'

    for move in moves:
        # Check the move is on the board and not already taken
        if not 0 <= move[0] <= 2 and not 0 <= move[1] <= 2:
            return "Invalid move (out of bounds)"
        if board[move[0]][move[1]] != '_':
            return "Invalid move (already taken)"

        # Place the move on the board
        board[move[0]][move[1]] = current_player

        # Check for a win
        result = check_winner(board)
        if result:
            return result

        # Switch players
        current_player = 'B' if current_player == 'A' else 'A'

    # We've made all moves, check for pending or draw
    return "Pending" if any('_' in row for row in board) else "Draw"


def main():
    # Convert input into integers, and pair them up
    array = [int(n) for n in sys.argv[1:]]
    moves = [array[i:i + 2] for i in range(0, len(array), 2)]

    result = find_winner(moves)
    print(result)


if __name__ == '__main__':
    main()
