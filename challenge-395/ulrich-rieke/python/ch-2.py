#!/usr/bin/env python3
from itertools import combinations , permutations

def condition( array ) -> bool:
   l = len( array[0] )
   recombined = []
   for n in range( 0 , l ):
      combined = ""
      for w in array:
         combined += w[n]
      recombined.append( combined )
   first = sorted( array ) 
   second = sorted( recombined )
   return first == second

line = input( "Enter some words with equal length!\n" )
words = line.split( ' ' )
solution = []
l = len( words[0] )
for combi in combinations( words , l):
   permus = permutations( combi )
   for perm in permus:
      if condition( perm ):
         solution.append( perm )
print( solution )         
