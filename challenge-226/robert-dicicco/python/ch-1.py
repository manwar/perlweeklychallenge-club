#!/usr/bin/env python
'''
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-19
Challenge 226 Task 1 Shuffle String ( Python )
--------------------------------------
'''
strings = ["lacelengh", "rulepark"]
indices = [[3,2,0,5,4,8,6,7,1],[4,7,3,1,0,5,2,6]]

offset = 0
cnt = 0


for str in strings:
    ndx = indices[offset]
    print(f"Input: $string = {str}, @indices = {indices[offset]}")
    cnt = 0
    ln = len(str)
    letters = dict()
    while cnt < ln:
        letter = str[cnt:cnt+1]
        x = ndx[cnt]
        letters[x] = letter
        cnt += 1
    cnt = 0
    print("Output: ", end="");
    while cnt < ln:
        print(letters[cnt], end="")
        cnt += 1
    print("\n")
    offset += 1

'''
--------------------------------------
SAMPLE OUTPUT
python .\ShuffleString.py

Input: $string = lacelengh, @indices = [3, 2, 0, 5, 4, 8, 6, 7, 1]
Output: challenge

Input: $string = rulepark, @indices = [4, 7, 3, 1, 0, 5, 2, 6]
Output: perlraku
--------------------------------------
'''


