#!/usr/bin/env python

'''

AUTHOR: Robert DiCicco

  DATE: 2022-11-25

  Challenge 192 Equal Distribution ( Python )

 

  You are given a list of integers greater than or equal to zero, @list.

 

  Write a script to distribute the number so that each members are same. If you succeed then print the total moves otherwise print -1.

 

  Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]

 

  1) You can only move a value of '1' per move

  2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell

  -----------------------------------------------

  SAMPLE OUTPUT

  raku .\EqualDistribution.rk

  Input: @lst = (1 0 5)

          (1 1 4)

          (1 2 3)

          (1 3 2)

          (2 2 2)

  Output: 4

 

  Input: @lst = (0 2 0)

  Output: -1

 

  Input: @lst = (0 3 0)

          (1 2 0)

          (1 1 1)

  Output: 2

  -----------------------------------------------

  SAMPLE OUTPUT

  python .\EqualDistribution.py

  Input: @lst =  [1, 0, 5]

          [1, 1, 4]

          [1, 2, 3]

          [1, 3, 2]

          [2, 2, 2]

  Output:  4

 

  Input: @lst =  [0, 2, 0]

  Output: -1

 

  Input: @lst =  [0, 3, 0]

          [1, 2, 0]

          [1, 1, 1]

  Output:  2

'''

 

lst = [[1,0,5],[0,2,0],[0,3,0]]

cnt = 0

 

def MaxPos( arr ) :

  max = 0

  maxpos = -1

  for x in range(3):

    if ((arr[x]) > max) :

      max = arr[x]

      maxpos = x

  return max, maxpos

 

def MinPos( arr ) :

  min = 9

  minpos = -1

  for x in range(3):

    if (arr[x] < min) :

      min = arr[x]

      minpos = x

  return min, minpos

 

def EvenUp( arr) :

  global cnt

  cnt += 1

  max, maxpos = MaxPos(arr)

  min, minpos = MinPos(arr)

  if (cnt > 1) :

    print("\t",arr)

  arr[maxpos] -= 1

  if ((maxpos == 0) or (maxpos == 2)) :

    arr[1] += 1

  else :

    arr[minpos] += 1

  if ((arr[0] == arr[1]) and (arr[1] == arr[2])) :

    print("\t",arr)

    print("Output: ",cnt)

    print(" ")

    cnt = 0

  else :

    EvenUp(arr);

 

def GetTotalVal(arr) :

  sum = 0;

  for i  in range(3) :

    #print(i)

    sum += arr[i]

  return sum

 

x = 0

while x < 3 :

  print("Input: @lst = ",lst[x])

  target = GetTotalVal(lst[x]) // 3

  if (target >= 1) :

    EvenUp(lst[x])

  else :

    print("Output: -1\n");

  x += 1
