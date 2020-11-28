#!/bin/env python
#===============================================================================
#
#         FILE: ch-2.py
#
#        USAGE: ./ch-2.py  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-088/
#  				Task 2
#  				Spiral Matrix
#
#       AUTHOR: Lubos Kolouch 
#      VERSION: 1.0
#      CREATED: 11/28/2020 01:02:17 PM
#===============================================================================

def get_spiral(in_arr):

    x_max = len(in_arr)
    y_max = len(in_arr[0])

    pos = [0,0]
    direction = ">"

    seen_cells = {}
    out_arr = []

    while 1:

        if len(out_arr) == x_max * y_max:
            return out_arr

        if seen_cells.get((pos[0], pos[1]), 0 ) == 0:
            out_arr.append(in_arr[pos[0]][pos[1]])

        seen_cells[(pos[0], pos[1])] = 1

        # can move in the direction we are walking?
        if direction == ">":
                if (pos[1] + 1 < x_max) and not (seen_cells.get( (pos[0], pos[1]+1), 0) ):
                        pos[1] += 1
                else:
                        direction = "v"

        elif direction == "v":
                if (pos[0] + 1 < y_max) and not (seen_cells.get( (pos[0]+1, pos[1]), 0) ):
                        pos[0] += 1
                else:
                        direction = "<"

        elif direction == "<":
                if (pos[0] - 1 >= 0) and not (seen_cells.get( (pos[0]-1, pos[1]), 0) ):
                        pos[0] -= 1
                else:
                        direction = "^"

        elif direction == "^":
                if (pos[1] - 1 >= 0) and not (seen_cells.get( (pos[0], pos[1]-1), 0) ):
                        pos[1] -= 1
                else:
                        direction = ">"

assert get_spiral([[1, 2, 3], [4, 5, 6], [7, 8, 9]]) == [1, 2, 3, 6, 9, 8, 7, 4, 5]
assert get_spiral([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]]) == [1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ] 

