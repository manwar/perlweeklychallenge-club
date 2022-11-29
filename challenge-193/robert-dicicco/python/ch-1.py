#!/usr/bin/env python

'''

AUTHOR: Robert DiCicco

DATE: 2022-11-28

Challenge 193 Binary String ( Python )

 

Write a script to find all possible binary numbers of size $n.

Example 1

 

Input: $n = 2

Output: 00, 11, 01, 10

 

Example 2

 

Input: $n = 3

Output: 000, 001, 010, 100, 111, 110, 101, 011

------------------------------------------------------

SAMPLE OUTPUT

python .\BinaryString.py

Input: $n =  2

Output:  00 01 10 11

 

Input: $n =  3

Output:  000 001 010 011 100 101 110 111

 

Input: $n =  4

Output:  0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111

'''

 

arr = [2,3,4]

 

for p in arr:

  print("Input: $n = ",p)

  rng = range(2**p)

  print("Output: ", end=" ")

  for n in rng :

    pw = "0" + str(p)

    print("{:{width}b}".format(n,width=pw), end=" ")

  print("\n")
