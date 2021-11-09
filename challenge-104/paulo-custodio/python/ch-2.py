#!/usr/bin/env python3

# Challenge 104
#
# TASK #2 > NIM Game
# Submitted by: Mohammad S Anwar
# Write a script to simulate the NIM Game.
#
# It is played between 2 players. For the purpose of this task, let assume you
# play against the machine.
#
# There are 3 simple rules to follow:
#
# a) You have 12 tokens
# b) Each player can pick 1, 2 or 3 tokens at a time
# c) The player who picks the last token wins the game

# A plays to win, B plays randomly, A wins 91% of the time
# If both play to win, the second player to play always wins

import sys
import random

matches = 100000
random_play = True
wins = {'A':0, 'B':0}

def draw_to_win(t):
    if t <= 3:
        return t        # win the game
    elif (t % 4)==0:
        return 1        # loose the game
    elif (t % 5)==0:
        return 1        # win the game
    elif (t % 6)==0:
        return 2        # win the game
    elif (t % 7)==0:
        return 3        # win the game
    elif (t % 9)==0:
        return 2        # win the game
    elif (t % 11)==0:
        return 2        # win the game
    else:
        return None     # not reached

def draw_random(t):
    return random.randint(1, 3)

def draw(t):
    global random_play

    if random_play:
        return draw_random(t)
    else:
        return draw_to_win(t)

def play_match():
    global wins
    t = 12
    while t > 0:
        for player in ['A', 'B']:
            if player=='A':
                move = draw_to_win(t)
            else:
                move = draw(t)
            t -= move
            if t <= 0:
                wins[player] += 1
                break

def play_matches():
    for i in range(0, matches):
        play_match()

if sys.argv[1]=="random":
    random_play = True
else:
    random_play = False
play_matches()
a_wins = int(100*wins['A']/(wins['A']+wins['B']))
print(f"A wins {a_wins}% of the matches.")
