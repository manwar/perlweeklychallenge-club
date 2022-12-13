#!/usr/bin/env python

'''

AUTHOR: Robert DiCicco

DATE  : 2022-12-13

Challenge 195 Special Integers ( Python )

 

SAMPLE OUTPUT

python .\SpecialIntegers.py

Input: $n =  15

Output: 14

 

Input: $n =  35

Output: 32

-------------------------------------------------

'''

 

def CheckUniqueDigits(n) :

  seen = {}

  my_list = [int(x) for x in str(n)]

  for onedig in my_list:

    if onedig in seen:

       return 0

    else :

       seen[onedig] = 1

  return 1

 

for n in [15, 35] :

  output = 0

  print("Input: $n = ", n)

  for x in range(0,n):

    output += CheckUniqueDigits(x)

  print(f"Output: {output}\n")
