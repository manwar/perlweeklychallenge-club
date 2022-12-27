#!/usr/bin/env python

'''

AUTHOR: Robert DiCicco

DATE  : 2022-12-26

Challenge 197 Move Zero ( Python )

'''

import array

 

lists = [[1, 0, 3, 0, 0, 5],[1, 6, 4],[0, 1, 0, 2, 0]]

 

 

for list in lists:

    i = 0

    left = []

    right = []

    out = []

    print(f"Input: @list = {list}")

    while i < len(list):

        if list[i] > 0:

            left.append(list[i])

        else:

            right.append(list[i])

        i += 1

    out = left + right

    print(f"Output: {out}\n")

   

'''

-----------------------------------------------

SAMPLE OUTPUT

python .\MoveZero.py

Input: @list = [1, 0, 3, 0, 0, 5]

Output: [1, 3, 5, 0, 0, 0]

 

Input: @list = [1, 6, 4]

Output: [1, 6, 4]

 

Input: @list = [0, 1, 0, 2, 0]

Output: [1, 2, 0, 0, 0]

'''
