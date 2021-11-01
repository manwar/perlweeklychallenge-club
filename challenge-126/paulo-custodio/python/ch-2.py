#!/usr/bin/env python3

# TASK #2 > Minesweeper Game
# Submitted by: Cheok-Yin Fung
# You are given a rectangle with points marked with either x or *. Please
# consider the x as a land mine.
#
# Write a script to print a rectangle with numbers and x as in the Minesweeper
# game.
#
# A number in a square of the minesweeper game indicates the number of mines
# within the neighbouring squares (usually 8), also implies that there are no
# bombs on that square.
#
# Example
# Input:
#     x * * * x * x x x x
#     * * * * * * * * * x
#     * * * * x * x * x *
#     * * * x x * * * * *
#     x * * * x * * * * x
#
# Output:
#     x 1 0 1 x 2 x x x x
#     1 1 0 2 2 4 3 5 5 x
#     0 0 1 3 x 3 x 2 x 2
#     1 1 1 x x 4 1 2 2 2
#     x 1 1 3 x 2 0 0 1 x

import fileinput

def read_input():
    lines = []
    for line in fileinput.input():
        lines.append(line)
    return lines

def parse_board(lines):
    board = []
    for line in lines:
        board.append(line.split())
    return board

def compute_mines(board):
    height = len(board)
    width  = len(board[0])

    def has_mine(r, c):
        if r < 0 or r >= height:
            return False
        elif c < 0 or c >= width:
            return False
        elif board[r][c] == 'x':
            return True
        else:
            return False

    for r in range(0, height):
        for c in range(0, width):
            if not has_mine(r, c):
                count = 0
                if has_mine(r-1, c-1):
                    count += 1
                if has_mine(r-1, c):
                    count += 1
                if has_mine(r-1, c+1):
                    count += 1
                if has_mine(r, c-1):
                    count += 1
                if has_mine(r, c+1):
                    count += 1
                if has_mine(r+1, c-1):
                    count += 1
                if has_mine(r+1, c):
                    count += 1
                if has_mine(r+1, c+1):
                    count += 1
                board[r][c] = str(count)

def print_board(board):
    for row in board:
        print(" ".join(row))

lines = read_input()
board = parse_board(lines)
compute_mines(board)
print_board(board)
