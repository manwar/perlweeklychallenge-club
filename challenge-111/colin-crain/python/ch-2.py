#!/usr/bin/env python3
#
#
#       get-in-line.py
#
#       Ordered Letters
#         Submitted by: E. Choroba
# 
#         Given a word, you can sort its letters alphabetically (case
#         insensitive). For example, “beekeeper” becomes “beeeeekpr” and
#         “dictionary” becomes “acdiinorty”.
# 
#         Write a script to find the longest English words that don’t change
#         when their letters are sorted.
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


dictFile = '/usr/share/dict/words'

def isSorted(word):
    if len(word) < 3:
        return False
    for i in range(1, len(word)):
        if word[i-1] > word[i]:
            return False
    return True

bag = {}

f = open(dictFile, "r")
for line in f:
    line = line.rstrip('\r\n').lower()
    if isSorted(line):
        bag[line] = len(line)
f.close

maxLen    = max( v for v in bag.values() )
longWords = [ w for w in bag if len(w) == maxLen ]

print("longest word length", maxLen, "letters", "\n")
for word in longWords:
    print(word)


