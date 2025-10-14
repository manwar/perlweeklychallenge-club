#!/usr/bin/env python3
from functools import cmp_to_key

def mySorter( a , b):
   firstOnes = a[1].count(1)
   secondOnes = b[1].count(1)
   if firstOnes != secondOnes:
      return firstOnes - secondOnes
   else:
      return a[1][b[0]] - b[1][a[0]]

line = input( "Enter a quadratic matrix of n rows with n 1 and 0 each, <return> to end!\n")
matrix = []
counter = 0 
while line:
   row = []
   for w in line.split(' '):
      row.append(int(w))
   matrix.append((counter , row))
   counter += 1
   line = input( "Enter a quadratic matrix of n rows with n 1 and 0 each, <return> to end!\n")   
sortedMatrix = sorted(matrix , key=cmp_to_key(mySorter))
print( "Team " + str(sortedMatrix[-1][0]))       
