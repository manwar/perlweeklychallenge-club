#!/usr/bin/env python3

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
            board = re.sub(rf'{ball}', f'{ball}{ball}', board, count=1)
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
