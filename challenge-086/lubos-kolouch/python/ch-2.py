#!env python
"""
#===============================================================================
#
#         FILE: ch-2.py
#
#        USAGE: ./ch-2.py
#
#  DESCRIPTION: Perl Weekly Challenge 086
#  				Task 2
#  				Sudoku Puzzle
#
#  				Uses backtrack algorithm
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 11/15/2020 01:27:06 PM
#===============================================================================
"""

import re
from copy import deepcopy


def load_puzzle(puzzle_input):
    """ load the puzzle from the input """

    puzzle = []
    for row in puzzle_input:
        row = re.sub("_", "0", row)

        puzzle.append(list(map(int, row.split(' '))))

    return puzzle


def get_valid_options(puzzle, row, col):
    """ eliminate numbers 1-9 that are already taken """

    valid_options = {}

    for i in range(10):
        valid_options[i] = 1

    # eliminate already taken numbers
    for i in range(9):
        try:
            del valid_options[puzzle[row][i]]
        except:
            pass

    for i in range(9):
        try:
            del valid_options[puzzle[i][col]]
        except:
            pass

    if not valid_options:
        return

    # eliminate quadrant

    for row_shift in range(3):
        for col_shift in range(3):
            row_pos = row // 3 * 3 + row_shift
            col_pos = col // 3 * 3 + col_shift

            try:
                del valid_options[puzzle[row_pos][col_pos]]
            except:
                pass

    return valid_options


def solve_position(puzzle_input):
    # backtrack recursively to find the solution

    next_puzzle = deepcopy(puzzle_input)

    for row, row_data in enumerate(next_puzzle):
        for col, item in enumerate(row_data):

            if item != 0:
                continue

            valid_options = get_valid_options(puzzle=next_puzzle, row=row, col=col)

            if not valid_options:
                # nothing left to try, check if the solution is complete

                for test_row in next_puzzle:
                    for test_item in test_row:
                        if item == 0:
                            return

                return next_puzzle

            for next_key in valid_options:
                next_puzzle[row][col] = next_key

                next_iteration = solve_position(deepcopy(next_puzzle))

                if next_iteration:
                    return next_iteration

    # great, we could fill all empty positions!
    return next_puzzle


def print_puzzle(puzzle):
    """ print the puzzle """

    for row in puzzle:
        print(' '.join(list(map(str, row))))
    print()


def solve_sudoku(puzzle):
    """ let's solve the puzzle! """

    puzzle = load_puzzle(puzzle)
    print_puzzle(puzzle)
    solution = solve_position(puzzle)
    print_puzzle(solution)
    return solution


assert solve_sudoku(['_ _ _ 2 6 _ 7 _ 1',
                     '6 8 _ _ 7 _ _ 9 _',
                     '1 9 _ _ _ 4 5 _ _',
                     '8 2 _ 1 _ _ _ 4 _',
                     '_ _ 4 6 _ 2 9 _ _',
                     '_ 5 _ _ _ 3 _ 2 8',
                     '_ _ 9 3 _ _ _ 7 4',
                     '_ 4 _ _ 5 _ _ 3 6',
                     '7 _ 3 _ 1 8 _ _ _']) == [
                        [4, 3, 5, 2, 6, 9, 7, 8, 1],
                        [6, 8, 2, 5, 7, 1, 4, 9, 3],
                        [1, 9, 7, 8, 3, 4, 5, 6, 2],
                        [8, 2, 6, 1, 9, 5, 3, 4, 7],
                        [3, 7, 4, 6, 8, 2, 9, 1, 5],
                        [9, 5, 1, 7, 4, 3, 6, 2, 8],
                        [5, 1, 9, 3, 2, 6, 8, 7, 4],
                        [2, 4, 8, 9, 5, 7, 1, 3, 6],
                        [7, 6, 3, 4, 1, 8, 2, 5, 9], ]
