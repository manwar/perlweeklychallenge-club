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

    def count_lone(self):
        """ count the occurences of lone X """

        for line_nr, line in enumerate(self.matrix):
            for col_nr, char in enumerate(line):
                if char == "O":
                    continue

                is_lone = True
                for d_x in [-1, 0, 1]:
                    for d_y in [-1, 0, 1]:
                        if d_x == d_y == 0:
                            continue

                        if line_nr + d_x < 0 or line_nr + d_x >= len(self.matrix):
                            continue

                        if col_nr + d_y < 0 or col_nr + d_y >= len(self.matrix):
                            continue

                        if self.matrix[line_nr + d_x][col_nr + d_y] == 'X':
                            is_lone = False
                            break

                if is_lone:
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
