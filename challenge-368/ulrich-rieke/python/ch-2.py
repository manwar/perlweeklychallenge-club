#!/usr/bin/env python3
def findFactors( number , mode):
   primefactors = []
   divisor = 2
   while number != 1:
      if number % divisor == 0:
         primefactors.append( divisor )
         number //= divisor
      else:
         divisor += 1
   if mode == 0:
      uniques = [num for num in primefactors if primefactors.count( num ) == 1]
      return len( uniques )
   else:
      return len( primefactors )

number = input( "Enter a positive number!\n" ) 
mode = input ("Enter a mode ( 0 or 1 )!\n" ) 
print( findFactors( int( number ) , int( mode )))
