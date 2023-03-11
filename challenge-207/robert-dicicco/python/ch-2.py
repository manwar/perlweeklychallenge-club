#!/usr/bin/env python
'''
----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-07
Challenge 207 H-Index ( Python )
==================================
'''
citations = [10,8,5,4,3],[25,8,5,3,3]

def CalcIndex(c):
    ln = len(c)
    offset = ln - 1
    pos = ln
    while offset >= 0 :
        if c[offset] >= pos :
            print("Output: ",pos,"\n")
            return
        else :
            offset -= 1
            pos -= 1

for c in citations:
    print("Input: @citations =",c)
    CalcIndex(c)

'''
----------------------------------
SAMPLE OUTPUT
python .\HIndex.py
Input: @citations = [10, 8, 5, 4, 3]
Output:  4

Input: @citations = [25, 8, 5, 3, 3]
Output:  3
----------------------------------
'''
