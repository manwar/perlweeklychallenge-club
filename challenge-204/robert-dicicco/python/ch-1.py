#!/usr/bin/env python

'''

-------------------------------------------------

AUTHOR: Robert DiCicco

DATE  : 2023-02-13

Challenge 204 Monotonic Array ( Python )

-------------------------------------------------

'''



nums = [[1,2,2,3],[1,3,2],[6,5,5,4]]



def CheckIncreasing(a,ln):

    cnt = 0

    while(cnt < ln - 1):

        if (a[cnt+1] >= a[cnt]):

            cnt += 1

        else:

            return 0

    return 1



def CheckDecreasing(a,ln):

    cnt = 0

    while(cnt < ln - 1):

        if (a[cnt+1] <= a[cnt]):

            cnt += 1

        else:

            return 0

    return 1



for n in nums:

    print("Input: @nums = ",n)

    ln = len(n)

    if ((CheckIncreasing(n,ln) == 0) and (CheckDecreasing(n,ln) == 0)) :

        print("0")

    if ((CheckIncreasing(n,ln) == 1) or (CheckDecreasing(n,ln) == 1)) :

        print("1")



'''

-------------------------------------------------

SAMPLE OUTPUT

python .\Monotones.py

Input: @nums =  [1, 2, 2, 3]

1

Input: @nums =  [1, 3, 2]

0

Input: @nums =  [6, 5, 5, 4]

1

'''
