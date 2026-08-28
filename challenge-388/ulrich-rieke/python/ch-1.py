#!/usr/bin/env python3
from itertools import permutations

def condition( word ):
   return all( [word[0:i].count( 'U' ) >= word[0:i].count( 'D' ) for i in \
         range( 1 , len( word ) )] )

numberstring = input ( "Enter a positive integer!\n" )
number = int( numberstring )
current = ""
if number == 0:
   print( "\"\"" )
else:   
   for i in range(0 , number):
      current += "U"
      current += "D"
   letters = [c for c in current]
   permuword = ""
   solution = []   
   for permu in permutations( letters ):
      for c in permu:
         permuword += c
      if condition( permuword ) and solution.count( permuword ) == 0:
         solution.append( permuword )
      permuword = ""
   result = sorted( solution )
   print( result )   
