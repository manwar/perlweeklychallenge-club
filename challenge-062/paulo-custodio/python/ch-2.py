#!/usr/bin/env python3

# Challenge 062
#
# TASK #2 > N Queens
# Submitted by: Ryan Thompson
#
# A standard 8x8 chessboard has 64 squares. The Queen is a chesspiece that can
# attack in 8 directions, as shown by the green shaded squares below:
#
#
#
# It is possible to place 8 queens on to a single chessboard such that none of
# the queens can attack each other (i.e., their shaded squares would not
# overlap). In fact, there are multiple ways to do so, and this is a favourite
# undergraduate assignment in computer science.
#
# But here at PWC, we're going to take it into the next dimension!
#
# Your job is to write a script to work with a three dimensional chess cube,
# MxMxM in size, and find a solution that maximizes the number of queens that
# can be placed in that cube without attacking each other. Output one possible
# solution.
#
# Example
# A trivial 2x2x2 solution might look like this (1 = queen, 0 = empty):
#
# [
#     [[1,0],     # Layer 1
#      [0,0]],
#
#     [[0,0],     # Layer 2
#      [0,0]],
# ]

from copy import deepcopy
import re

M = 2

board = [[[0 for _ in range(M)] for _ in range(M)] for _ in range(M)]
max_board = deepcopy(board)
max_queens = 0

def set_position(board, l, r, c):
    if 0 <= l < M and 0 <= r < M and 0 <= c < M:
        board[l][r][c] = 1

def place_queens(queens, board):
    global max_queens, max_board

    # check for empty spaces
    full = True
    for l in range(M):
        for r in range(M):
            for c in range(M):
                if board[l][r][c] == 0:
                    full = False
                    # empty, place queen
                    copy_board = deepcopy(board)
                    # fill attack positions
                    for i in range(M):
                        set_position(copy_board, i, r, c)
                        set_position(copy_board, l, i, c)
                        set_position(copy_board, l, r, i)

                        set_position(copy_board, l, r-i, c-i)
                        set_position(copy_board, l, r-i, c+i)
                        set_position(copy_board, l, r+i, c-i)
                        set_position(copy_board, l, r+i, c+i)

                        set_position(copy_board, l-i, r, c-i)
                        set_position(copy_board, l-i, r, c+i)
                        set_position(copy_board, l+i, r, c-i)
                        set_position(copy_board, l+i, r, c+i)

                        set_position(copy_board, l-i, r-i, c)
                        set_position(copy_board, l-i, r+i, c)
                        set_position(copy_board, l+i, r-i, c)
                        set_position(copy_board, l+i, r+i, c)

                        set_position(copy_board, l-i, r-i, c-i)
                        set_position(copy_board, l-i, r-i, c+i)
                        set_position(copy_board, l-i, r+i, c-i)
                        set_position(copy_board, l-i, r+i, c+i)

                        set_position(copy_board, l+i, r-i, c-i)
                        set_position(copy_board, l+i, r-i, c+i)
                        set_position(copy_board, l+i, r+i, c-i)
                        set_position(copy_board, l+i, r+i, c+i)
                    # fill queen position
                    copy_board[l][r][c] = 'Q'
                    # recurse
                    place_queens(queens + 1, copy_board)
    if full:
        if queens > max_queens:
            max_queens = queens
            max_board = deepcopy(board)

place_queens(0, board)
out = str(max_board)
out, _ = re.subn("'", '"', out)
print(out)
