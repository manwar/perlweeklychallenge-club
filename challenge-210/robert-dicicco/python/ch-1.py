#!/usr/bin/env python
'''
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-28
Challenge 210 Kill&Win ( Python )
--------------------------------------
'''
myint =[[2,3,1],[1,1,2,2,2,3]]

def Score(arr):
    global total_score,max_score;
    total_score = 0
    max_score = 0

    for testx in arr:
        print(f"trying {testx}")
        for val in arr:
            if ((val == testx) or (val == testx-1) or (val == testx+1)) :
                total_score += val
        if total_score == max_possible:
            print(f"Output: {total_score}")
            print("")
            return
        if total_score > max_score:
            max_score = total_score
        total_score = 0

for a in myint:
    global max_possible;
    print(f"Input: @int = {a}")
    max_possible = sum(a)
    print(f"max_possible = {max_possible}")
    Score(a)
'''
--------------------------------------
SAMPLE OUTPUT
python .\KillWin.py
Input: @int = [2, 3, 1]
max_possible = 6
trying 2
Output: 6

Input: @int = [1, 1, 2, 2, 2, 3]
max_possible = 11
trying 1
trying 1
trying 2
Output: 11
--------------------------------------
'''


