#!/usr/bin/env python3
from itertools import combinations

line = input( "Enter some integers separated by blanks!\n" ) 
numbers = [int( w ) for w in line.split( ' ' )]
pairs = [] 
l = len( numbers ) 
for i in range(1 , l + 1):
   pairs.append((i , numbers[i - 1]) )
solution = []
for d in range( 2 , l  ):
   for p in combinations( pairs , d ):
      for values in p:
         indexsum = sum([values[0] for values in p]) 
         numbersum = sum([values[1] for values in p])
         if indexsum == numbersum:
            solution.append( [values[1] for values in p] ) 
output = []
for pair in solution:
   if pair not in output:
      output.append( pair )
print( output )      
      
