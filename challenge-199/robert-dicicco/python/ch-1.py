#!/usr/bin/env python

'''

AUTHOR: Robert DiCicco

DATE  : 2023-01-09

Challenge 199 Good Pairs ( Python )

'''

 

lists = [[1,2,3,1,1,3],[1,2,3],[1,1,1,1]]

finalCnt = 0

 

for list in lists:

    print(f"Input: @list = {list}")

    beginner = 0

    ender = len(list) - 1

    cnt = beginner + 1

    while beginner < ender:

        while cnt <= ender:

            if list[cnt] == list[beginner]:

                print(f"{beginner},{cnt}")

                finalCnt += 1

            cnt += 1

        beginner += 1

        cnt = beginner + 1

    print(f"Output: {finalCnt}\n")

    finalCnt = 0

      

'''

SAMPLE OUTPOUT

python .\GoodPairs.py

Input: @list = [1, 2, 3, 1, 1, 3]

0,3

0,4

2,5

3,4

Output: 4

 

Input: @list = [1, 2, 3]

Output: 0

 

Input: @list = [1, 1, 1, 1]

0,1

0,2

0,3

1,2

1,3

2,3

Output: 6

'''
