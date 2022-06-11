#!/usr/bin/env python3

# Challenge 044
#
# TASK #2
# Make it $200
# You have only $1 left at the start of the week. You have been given an
# opportunity to make it $200. The rule is simple with every move you can either
# double what you have or add another $1. Write a script to help you get $200
# with the smallest number of moves.

min_moves = "+".join(["1" for x in range(200)])

def find_min_moves(moves, num):
    global min_moves
    if num > 200:
        pass
    elif num == 200:
        if len(moves) < len(min_moves):
            min_moves = moves
    else:
        find_min_moves(moves+"*2", num*2)
        find_min_moves(moves+"+1", num+1)

find_min_moves("1", 1)
print(min_moves)
