#!/usr/bin/env python3

# Challenge 046
#
# TASK #1
# Cryptic Message
# The communication system of an office is broken and message received are not
# completely reliable. To send message Hello, it ended up sending these following:
#
# H x l 4 !
# c e - l o
# z e 6 l g
# H W l v R
# q 9 m # o
# Similary another day we received a message repeatedly like below:
#
# P + 2 l ! a t o
# 1 e 8 0 R $ 4 u
# 5 - r ] + a > /
# P x w l b 3 k \
# 2 e 3 5 R 8 y u
# < ! r ^ ( ) k 0
# Write a script to decrypt the above repeated message (one message repeated 6
# times).
#
# HINT: Look for characters repeated in a particular position in all six messages
# received.

import sys

def read_input():
    input = []
    for line in sys.stdin:
        input.append(line.rstrip())
    return input

def decode(input):
    decoded = ""
    for col in range(len(input[0])):
        hist = {}
        max_letter, max_count = '', 0
        for row in range(len(input)):
            letter = input[row][col]
            if letter not in hist:
                hist[letter] = 1
            else:
                hist[letter] += 1
            if hist[letter] > max_count:
                max_letter, max_count = letter, hist[letter]
        decoded += max_letter
    return decoded


input = read_input()
decoded = decode(input)
print(decoded)
