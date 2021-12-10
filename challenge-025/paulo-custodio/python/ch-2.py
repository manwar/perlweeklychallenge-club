#!/usr/bin/python3

# Challenge 025
#
# Task #2
# Create script to implement Chaocipher. Please checkout wiki page for more
# information.

import sys
import re

left  = "HXUCZVAMDSLKPEFJRIGTWOBNYQ"
right = "PTLNBQDEOYSFAVZKGJRIHWXUMC"

def permute_alphabets(pos):
    global left, right

    # permute left alphabet
    left = left[pos:]+left[:pos]
    left = left[0]+left[2:14]+left[1]+left[14:]

    # permute right alphabet
    right = right[pos:]+right[:pos]
    right = right[1:]+right[0]
    right = right[:2]+right[3:14]+right[2]+right[14:]

def find_pos(letter, alphabet):
    found = re.search(letter, alphabet)
    return found.start(0)

def encode(text):
    global left, right

    encoded = ""
    for letter in text:
        pos = find_pos(letter, right)
        code = left[pos]
        encoded += code

        permute_alphabets(pos)
    return encoded

def decode(encoded):
    global left, right

    text = ""
    for code in encoded:
        pos = find_pos(code, left)
        letter = right[pos]
        text += letter

        permute_alphabets(pos)
    return text

if sys.argv[1]=="encode":
    print(encode(sys.argv[2]))
elif sys.argv[1]=="decode":
    print(decode(sys.argv[2]))
else:
    print("Usage: ch-2.py encode|decode text")
