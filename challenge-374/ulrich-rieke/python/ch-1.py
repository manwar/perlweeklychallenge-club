#!/usr/bin/env python3

def condition( word ):
   return set( word ) == set( "aeiou" )
   
string = input( "Enter a string!\n" )
l = len( string )
solution = []   
if l == 5:
   if condition( string ):
      solution.append( string )
if l > 5:         
   for start in range( 0 , l - 4 ):
      for end in range( start + 5 , l + 1):
         substring = string[start:end]
         if condition( substring ):
            solution.append( substring )
print( solution )         
