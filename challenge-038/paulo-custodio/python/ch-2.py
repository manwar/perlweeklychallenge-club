#!/usr/bin/env python3

# Challenge 038
#
# TASK #2
# Word Game
# Lets assume we have tiles as listed below, with an alphabet (A..Z) printed
# on them. Each tile has a value, e.g. A (1 point), B (4 points) etc. You are
# allowed to draw 7 tiles from the lot randomly. Then try to form a word using
# the 7 tiles with maximum points altogether. You don't have to use all the
# 7 tiles to make a word. You should try to use as many tiles as possible to
# get the maximum points.
#
# For example, A (x8) means there are 8 tiles with letter A.
#
# 1 point
# A (x8), G (x3), I (x5), S (x7), U (x5), X (x2), Z (x5)
#
# 2 points
# E (x9), J (x3), L (x3), R (x3), V (x3), Y (x5)
#
# 3 points
# F (x3), D (x3), P (x5), W (x5)
#
# 4 points
# B (x5), N (x4)
#
# 5 points
# T (x5), O (x3), H (x3), M (x4), C (x4)
#
# 10 points
# K (x2), Q (x2)

import sys
import re

g_score = {'a':1,'g':1,'i':1,'s':1,'u':1,'x':1,'z':1,
           'e':2,'j':2,'l':2,'r':2,'v':2,'y':2,
           'f':3,'d':3,'p':3,'w':3,
           'b':4,'n':4,
           't':5,'o':5,'h':5,'m':5,'c':5,
           'k':10,'q':10}
g_count = {'a':8,'g':3,'i':5,'s':7,'u':5,'x':2,'z':5,
           'e':9,'j':3,'l':3,'r':3,'v':3,'y':5,
           'f':3,'d':3,'p':5,'w':5,
           'b':5,'n':4,
           't':5,'o':3,'h':3,'m':4,'c':4,
           'k':2,'q':2}

def check_word(word):
    # maximium 7 letters, only lower case letters
    if not re.match(r"^[a-z]{1,7}$", word):
        return -1

    # less than count tiles for each letter
    for letter in word:
        if letter.count(letter) > g_count[letter]:
            return -1

    # compute score
    score = 0
    for letter in word:
        score += g_score[letter]

    return score


dict = sys.argv[1]
max_score = 0
max_word = ""

with open(dict) as f:
    for line in f.readlines():
        word = line.rstrip()
        score = check_word(word)
        if score > 0 and score > max_score:
            max_score, max_word = score, word

print(max_score, max_word)
