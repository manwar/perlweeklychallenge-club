#!/usr/bin/env python

'''

AUTHOR: Robert DiCicco

DATE:   2023-01-23

Challenge 201 Missing Numbers ( Python )

'''

arrs = [[0,1,3],[0,1]]



for arr in arrs:

    print(f"Input: @array = {arr}")

    arrlen = len(arr)

    for x in range(arrlen+1) :

        if x not in arr :

            print("Output: ",x,"\n")



'''

SAMPLE OUTPUT

python .\MissingNumbers.py

Input: @array = [0, 1, 3]

Output:  2



Input: @array = [0, 1]

Output:  2

'''
