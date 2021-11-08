#!/usr/bin/env python3

# Challenge 004
#
# Challenge #2
# You are given a file containing a list of words (case insensitive 1 word per
# line) and a list of letters. Print each word from the file that can be made
# using only letters from the list. You can use each letter only once (though
# there can be duplicates and you can use each of them once), you don't have to
# use all the letters.
# (Disclaimer: The challenge was proposed by Scimon Proctor)

import sys
import re

def isalpha(word):
    if re.fullmatch(r"[a-zA-Z]+", word):
        return True
    else:
        return False

def matches_letters(word, letters):
    for c in letters:
        word = re.sub(c, "", word, 1)
        if word == "":
            return True
    return False

def print_matching(file, letters):
    letters = letters.lower()
    fp = open(file, 'r')
    for line in fp.readlines():
        word = line.strip()
        if isalpha(word) and len(word) >= 2 and matches_letters(word, letters):
            print(word)

if len(sys.argv) != 2:
    print("Usage: ch-2.py letters")
else:
    print_matching("words.txt", sys.argv[1])
