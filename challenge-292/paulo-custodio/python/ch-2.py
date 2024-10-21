#!/usr/bin/env python3

# Challenge 292
#
# Task 2: Zuma Game
# Submitted by: Mohammad Sajid Anwar
#
# You are given a single row of colored balls, $row and a random number of
# colored balls in $hand.
#
# Here is the variation of Zuma game as your goal is to clear all of the balls
# from the board. Pick any ball from your hand and insert it in between two
# balls in the row or on either end of the row. If there is a group of three
# or more consecutive balls of the same color then remove the group of balls
# from the board. If there are no more balls on the board then you win the game.
# Repeat this process until you either win or do not have any more balls in
# your hand.
#
# Write a script to minimum number of balls you have to insert to clear all
# the balls from the board. If you cannot clear all the balls from the board
# using the balls in your hand, return -1.
# Example 1
#
# Input: $board = "WRRBBW", $hand = "RB"
# Output: -1
#
# It is impossible to clear all the balls. The best you can do is:
# - Insert 'R' so the board becomes WRRRBBW. WRRRBBW -> WBBW.
# - Insert 'B' so the board becomes WBBBW. WBBBW -> WW.
# There are still balls remaining on the board, and you are out of balls to insert.
#
# Example 2
#
# Input: $board = "WWRRBBWW", $hand = "WRBRW"
# Output: 2
#
# To make the board empty:
# - Insert 'R' so the board becomes WWRRRBBWW. WWRRRBBWW -> WWBBWW.
# - Insert 'B' so the board becomes WWBBBWW. WWBBBWW -> WWWW -> empty.
# 2 balls from your hand were needed to clear the board.
#
# Example 3
#
# Input: $board = "G", $hand = "GGGGG"
# Output: 2
#
# To make the board empty:
# - Insert 'G' so the board becomes GG.
# - Insert 'G' so the board becomes GGG. GGG -> empty.
# 2 balls from your hand were needed to clear the board.

import sys
import re

def draw(board, hand):
    not_yet = {}
    for ball in board:
        if re.search(rf'{ball}[^{ball}]+{ball}', board):
            not_yet[ball] = 1

    if re.search(r'(.)\1', board):
        it = re.finditer(r'(.)\1', board)
        while m := next(it):
            ball = m.group(1)
            if ball not in not_yet and ball in hand:
                board = re.sub(rf'{ball}{{2,}}', '', board)
                board = re.sub(r'(.)\1\1+', '', board)
                hand = hand.replace(ball, '', 1)
                return 1, board, hand

    for ball in board:
        if ball in hand:
            board = re.sub(rf'{ball}', f'{ball}{ball}', board, 1)
            board = re.sub(r'(.)\1\1+', '', board)
            hand = hand.replace(ball, '', 1)
            return 1, board, hand

    return 0, board, hand

def play(board, hand):
    rounds = 0
    while True:
        if board == '':
            return rounds
        if hand == '':
            return -1
        moved, board, hand = draw(board, hand)
        if not moved:
            return -1
        rounds += 1

print(play(sys.argv[1], sys.argv[2]))
