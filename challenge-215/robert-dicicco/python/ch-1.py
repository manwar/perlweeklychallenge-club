#!/usr/bin/env python
'''
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-01
Challenge 215 Odd One Out ( Python )
----------------------------------------
'''

words = [["abc","xyz","tsu"],["rat", "cab", "dad"],["x", "y", "z"]]

for wds in words:
    cnt = 0
    print("Input: @words = ",wds)
    for w in wds:
        w_sorted = ''.join(sorted(w, key=str.lower))
        if w != w_sorted:
            cnt += 1
    print("Output: ",cnt,"\n")

'''
 ----------------------------------------
SAMPLE OUTPUT
python .\OddOneOut.py
Input: @words =  ['abc', 'xyz', 'tsu']
Output:  1
Input: @words =  ['rat', 'cab', 'dad']
Output:  3
Input: @words =  ['x', 'y', 'z']
Output:  0
 ----------------------------------------
'''


