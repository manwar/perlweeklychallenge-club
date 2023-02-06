#!/usr/bin/env python



# AUTHOR: Robert DiCicco

# DATE  : 2023-01-30

# Challenge 202 Consecutive Odds ( Python )



import re



arrays = [[1,5,3,6],[2,6,3,5],[1,2,3,4],[2,3,5,7]]



for arr in arrays :

    print("Input: @array = ",arr)

    check = ''

    for x in range(0,len(arr)) :

        if (arr[x] % 2 == 0) :

            check += 'e'

        else :

            check += 'o'

    if check.find('ooo') >= 0 :

        print("Output: 1\n")

    else:

        print("Output: 0\n")



# SAMPLE OUTPUT

# python .\ConsecutiveOdds.py

# Input: @array =  [1, 5, 3, 6]

# Output: 1



# Input: @array =  [2, 6, 3, 5]

# Output: 0



# Input: @array =  [1, 2, 3, 4]

# Output: 0



# Input: @array =  [2, 3, 5, 7]

# Output: 1
