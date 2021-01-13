#!/usr/bin/env python
""" Challenge 2 Python """
# ===============================================================================
#
#         FILE: ch-2.py
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-076/
#
#              Task 2 - Word Search
#
#       AUTHOR: Lubos Kolouch
# ===============================================================================
import sys


class GridWords:
    """ class for processing the grid, wordlist and returning matches """

    def __init__(self, grid_file, words_file, min_count=5):
        self.grid = list()
        self.words = list()
        self.load_grid_to_list(grid_file)
        self.load_words_to_list(words_file)
        self.min_count = min_count
        self.x_size = len(self.grid) 
        self.y_size = len(self.grid[0]) 
        self.big_string = ''

    def load_grid_to_list(self, grid_file):
        """ Convert input grid to 2D list """
        in_file = open(grid_file, "r")
        grid_load = in_file.readlines()

        for what in grid_load:
            self.grid.append(what.strip().split(' '))

    def load_words_to_list(self, words_file):
        """ Convert file with words to list """
        in_file = open(words_file, "r")

        for line in in_file.readlines():
            self.words.append(line.strip())

    def add_rows_to_big_string(self):
        """ add all rows """
        for pos_x in range(self.x_size):
            for pos_y in range(self.y_size):
                self.big_string += self.grid[pos_x][pos_y]
            # at the end of row we need a break
            self.big_string += '_'

    def add_columns_to_big_string(self):
        """ add all columns """

        for pos_y in range(self.y_size):
            for pos_x in range(self.x_size):
                self.big_string += self.grid[pos_x][pos_y]

            self.big_string += '_'

    def add_diag_1_to_big_string(self):
        """ add diagonal 1 to big string """

        for pos_x in range(self.x_size):
            for pos_y in range(self.y_size):
                if pos_x + pos_y >= self.x_size:
                    break
                self.big_string += self.grid[pos_x+pos_y][pos_y]

            self.big_string += '_'

    def add_diag_2_to_big_string(self):
        """ add diagonal 2 to big string """

        for pos_y in range(self.y_size):
            for pos_x in range(self.x_size):
                if pos_x + pos_y >= self.y_size:
                    break
                self.big_string += self.grid[pos_x][pos_x+pos_y]

            self.big_string += '_'

    def add_diag_3_to_big_string(self):
        """ add diagonal 3 to big string """

        for pos_x in range(self.x_size):
            for pos_y in range(self.y_size):
                if pos_x + pos_y >= self.x_size:
                    break
                self.big_string += self.grid[pos_x+pos_y][self.y_size - 1 - pos_y]

            self.big_string += '_'

    def add_diag_4_to_big_string(self):
        """ add diagonal 4 to big string """

        for pos_y in range(self.y_size):
            for pos_x in range(self.x_size):
                if pos_x + pos_y > self.y_size:
                    break
                self.big_string += self.grid[pos_x][self.y_size - 1 - pos_y - pos_x]

            self.big_string += '_'

    def get_words(self):
        """ get number of found words with minimal length min_count """

        self.add_rows_to_big_string()
        self.add_columns_to_big_string()
        self.add_diag_1_to_big_string()
        self.add_diag_2_to_big_string()
        self.add_diag_3_to_big_string()
        self.add_diag_4_to_big_string()

        self.big_string += self.big_string[::-1]

        count = 0
        for word in self.words:
            if len(word) < self.min_count:
                continue

            if self.big_string.find(word.upper()) != -1:
                count += 1

        return count


if len(sys.argv) != 3:
    print('usage: script grif_file words_file')
    sys.exit(1)

grid_f = sys.argv[1]
words_f = sys.argv[2]

words_processor = GridWords(grid_f, words_f, 5)

print(words_processor.get_words())
