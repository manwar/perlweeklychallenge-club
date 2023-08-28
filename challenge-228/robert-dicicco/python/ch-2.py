#!/usr/bin/env python
# ---------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-08-01
# Challenge 228 Task 2 Empty Array ( Python )
# ---------------------------------------

myints = [[3, 4, 2],[1,2,3]]

for i in myints:
    print(f"Input: @int = {i}")
    cnt = 0
    while len(i) > 0:
        mn = min(i)
        if (i[0] == mn):
            i.pop(0)
        else:
            i.append(i[0])
            i.pop(0)
        print(i) if len(i) > 0 else print("()")
        cnt += 1
    print(f"Output: {cnt}\n")

# ---------------------------------------
# SAMPLE OUTPUT
# python  .\EmptyArray.py
# #
# Input: @int = [3, 4, 2]
# [4, 2, 3]
# [2, 3, 4]
# [3, 4]
# [4]
# ()
# Output: 5
# #
# Input: @int = [1, 2, 3]
# [2, 3]
# [3]
# ()
# Output: 3
# ---------------------------------------



