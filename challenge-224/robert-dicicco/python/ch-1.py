#!/usr/bin/env python
# ----------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-07-04
# Challenge 224 Task 1 Special Notes ( Python )
# ----------------------------------------------

import sys

source = sys.argv[1]
target = sys.argv[2]

flag = 0
offset = 0

while offset < len(target):
     letter = target[offset]
     index = source.find(letter)
     if index == -1:
        print("Output: false")
        flag = -1
        break
     offset += 1

if flag == 0 :
    print("Output: true")


# ----------------------------------------------
# python .\SpecialNotes.py scriptinglanguage perl
# Output: true

# python .\SpecialNotes.py abc xyz
# Output: false

# python .\SpecialNotes.py aabbcc abc
# Output: true
# ----------------------------------------------


