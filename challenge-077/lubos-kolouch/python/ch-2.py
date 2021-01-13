#!/bin/env python
""" Perl Weekly challenge 077 Task 2
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/
    Solution Lubos Kolouch """


class LoneX:
    """ Class for solving the challenge """

    def __init__(self, matrix: list):
        """ init the solution """
        self.matrix = matrix
        self.solution_count = 0

    def check_position(self, pos_x: int, pos_y: int):
        """ check if the position is lone """

        for d_x in [-1, 0, 1]:
            for d_y in [-1, 0, 1]:
                if d_x == d_y == 0:
                    continue

                if pos_x + d_x < 0 or pos_x + d_x >= len(self.matrix):
                    continue

                if pos_y + d_y < 0 or pos_y + d_y >= len(self.matrix):
                    continue

                if self.matrix[pos_x + d_x][pos_y + d_y] == 'X':
                    return False

        return True

    def count_lone(self):
        """ count the occurences of lone X """

        for pos_x, line in enumerate(self.matrix):
            for pos_y, char in enumerate(line):
                if char == "O":
                    continue

                if self.check_position(pos_x, pos_y):
                    self.solution_count += 1

    def get_count(self):
        """ just return the solutions count """

        return self.solution_count


lonex = LoneX([['O', 'O', 'X'], ['X', 'O', 'O'], ['X', 'O', 'O']])
lonex.count_lone()
assert lonex.get_count() == 1

lonex2 = LoneX([['O', 'O', 'X', 'O'], ['X', 'O', 'O', 'O'],
                ['X', 'O', 'O', 'X'], ['O', 'X', 'O', 'O']])
lonex2.count_lone()
assert lonex2.get_count() == 2
