#!/usr/bin/env python
# ------------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-06-05
# Challenge 220 Task 1 common Characters ( Python )
# ------------------------------------------------

words = [["Perl", "Rust", "Raku"], ["love", "live", "leave"]]

alphabet_hash = {}

for wds in words:
    for char in range(ord('a'), ord('z')+1):
        alphabet_hash[chr(char)] = 0

    print("Input: @words = ",wds)
    for wd in wds:
        wd = wd.lower()
        for ch in wd:
            alphabet_hash[ch] += 1

    print("Output: ",end= " ")
    for i in alphabet_hash:
        if alphabet_hash[i] >= 3:
            print(i,end=" ")
    print("\n")

# ------------------------------------------------
# SAMPLE OUTPUT
# python .\CommonChars.py

# Input: @words =  ['Perl', 'Rust', 'Raku']
# Output:  r

# Input: @words =  ['love', 'live', 'leave']
# Output:  e l v

# ------------------------------------------------
