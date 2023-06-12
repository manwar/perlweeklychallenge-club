#!/usr/bin/env python
# ------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-06-00
# Challenge 220 Task 2 Squareful ( Python )
# ------------------------------------------
import math
from itertools import permutations


myints = [[1,8,17],[1,8,17,19]]

def IsPerfectSquare(number_to_test) :
    root = math.floor(math.sqrt(number_to_test))
    if ((root ** 2 ) == number_to_test) :
        return True;
    return False;

for intsub in myints:
    print("Input: @ints = ",intsub)
    print("OutPut: ",end="")
    perm = permutations(intsub)
    for i in list(perm):
        ln = len(i) - 1
        tv = 0
        flag = 0
        while tv < ln :
            if IsPerfectSquare(i[tv] + i[tv + 1]) :
                flag += 1
            else :
                flag = 0
            tv += 1
        if flag == ln - 1 :
             print(i,end=" ")
    print("\n")

#------------------------------------------
# SAMPLE OUTPUT
# python .\Squareful.py

# Input: @ints =  [1, 8, 17]
# OutPut: (1, 17, 8) (17, 1, 8)

# Input: @ints =  [1, 8, 17, 19]
# OutPut: (1, 19, 17, 8) (19, 1, 8, 17)
#------------------------------------------



