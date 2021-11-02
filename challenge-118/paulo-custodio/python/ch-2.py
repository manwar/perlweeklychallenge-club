#!/usr/bin/env python3

# Challenge 118
#
# TASK #2 - Adventure of Knight
# Submitted by: Cheok-Yin Fung
# A knight is restricted to move on an 8x8 chessboard. The knight is denoted by
# N and its way of movement is the same as what it is defined in Chess.
# * represents an empty square. x represents a square with treasure.
#
# The Knight's movement is unique. It may move two squares vertically and one
# square horizontally, or two squares horizontally and one square vertically
# (with both forming the shape of an L).
#
# There are 6 squares with treasures.
#
# Write a script to find the path such that Knight can capture all treasures.
# The Knight can start from the top-left square.
#
#       a b c d e f g h
#     8 N * * * * * * * 8
#     7 * * * * * * * * 7
#     6 * * * * x * * * 6
#     5 * * * * * * * * 5
#     4 * * x * * * * * 4
#     3 * x * * * * * * 3
#     2 x x * * * * * * 2
#     1 * x * * * * * * 1
#       a b c d e f g h
#

# https://en.m.wikipedia.org/wiki/Knight%27s_tour

import copy
import re
import sys

def check_header(line):
    if not re.search(r"a b c d e f g h", line):
        print("expected header")
        sys.exit(1)

solution = None

class Board():
    def __init__(self):
        self.board = [[0 for i in range(8)] for j in range(8)]
        self.treasures = set()
        self.path = []

    def parse(self):
        self.board = [[0 for i in range(8)] for j in range(8)]
        self.treasures = set()
        self.path = []

        line = input()
        check_header(line)

        for row in range(8):
            line = input()
            cells = line.split()
            if cells[0] != str(8-row):
                print("expected row "+str(y))
                sys.exit(1)
            cells.pop(0)

            for col in range(8):
                if cells[col] == 'N':
                    self.path.append((row,col))
                    self.board[row][col] = 1
                elif cells[col] == 'x':
                    self.treasures.add((row,col))

        line = input()
        check_header(line)

    def next_moves(self, row, col):
        moves = []
        for drow, dcol in [(-2, -1), (-2, +1), (+2, -1), (+2, +1), \
                           (+1, -2), (-1, -2), (+1, +2), (-1, +2)]:
            nrow = row+drow
            ncol = col+dcol
            if 0 <= nrow < 8 and 0 <= ncol < 8:
                if self.board[nrow][ncol]==0:
                    moves.append((nrow, ncol))
        return moves

    def next_possible_moves(self):
        # get moves from last position in path
        row, col = self.path[-1]
        moves = self.next_moves(row, col)
        moves_count = []

        # count possible moves from each destination
        min_count = 1000
        for nrow, ncol in moves:
            moves2 = self.next_moves(nrow, ncol)
            count = len(moves2)
            moves_count.append(count)
            min_count = min(count, min_count)

        # select moves with minimum count
        sel_moves = []
        for i in range(0, len(moves)):
            if moves_count[i]==min_count:
                sel_moves.append(moves[i])

        return sel_moves

    def path_str(self):
        moves = []
        for row, col in self.path:
            x = chr(ord('a')+col)
            y = str(8-row)
            moves.append(x+y)
        return " ".join(moves)

    def solve(self):
        global solution

        if len(self.treasures)==0:     # all treasures found
            if solution is None or \
               len(solution.path) > len(self.path):
                solution = copy.deepcopy(self)
        else:
            moves = self.next_possible_moves()
            for row, col in moves:
                new_board = copy.deepcopy(self)
                new_board.board[row][col] = 1
                new_board.path.append((row, col))
                if (row, col) in new_board.treasures:
                    new_board.treasures.remove((row, col))
                new_board.solve()

board = Board()
board.parse()
board.solve()
print(solution.path_str())

